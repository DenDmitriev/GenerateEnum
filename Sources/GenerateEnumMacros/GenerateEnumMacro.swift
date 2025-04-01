import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

public struct GenerateEnumMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        guard let args = node.arguments?.as(LabeledExprListSyntax.self),
              let baseArg = args.first(where: { $0.label?.text == "base" })?.expression.as(DeclReferenceExprSyntax.self),
              let nameArg = args.first(where: { $0.label?.text == "name" })?.expression.as(StringLiteralExprSyntax.self)
        else {
            throw MacroError.message("Expected 'base' and 'name' arguments")
        }
        
        let baseClass = baseArg.baseName.text
        let enumName = nameArg.segments.description.replacingOccurrences(of: "\"", with: "")
        
        // Получаем все вложенные классы внутри базового класса
        guard let baseDecl = declaration.as(EnumDeclSyntax.self) else {
            throw MacroError.message("Expected to be used on an enum")
        }
        
        let subclassDecls = baseDecl.memberBlock.members.compactMap { member -> String? in
            guard let classDecl = member.decl.as(ClassDeclSyntax.self) else { return nil }
            return classDecl.name.text
        }
        
        guard !subclassDecls.isEmpty else {
            throw MacroError.message("No subclasses found in \(baseClass)")
        }
        
        // Генерируем кейсы
        let cases = subclassDecls.map { subclass in
            "case \(subclass.lowercased())(\(baseClass).\(subclass))"
        }.joined(separator: "\n")
        
        // Генерируем init?(shared:)
        let initCases = subclassDecls.map { subclass in
            "case let \(subclass.lowercased()) as \(baseClass).\(subclass): return .\(subclass.lowercased())(\(subclass.lowercased()))"
        }.joined(separator: "\n")
        
        let enumDecl = """
        public enum \(enumName) {
            \(cases)
            
            var component: Any {
                switch self {
                \(subclassDecls.map { subclass in
                    "case .\(subclass.lowercased())(let instance): return instance.component"
                }.joined(separator: "\n"))
                }
            }
            
            init?(shared: \(baseClass)) {
                switch shared {
                \(initCases)
                default: return nil
                }
            }
        }
        """
        
        return [DeclSyntax(stringLiteral: enumDecl)]
    }
}

@main
struct GenerateEnumPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        GenerateEnumMacro.self
    ]
}

public enum MacroError: Error {
    case message(String)
}
