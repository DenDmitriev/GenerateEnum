import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct GenerateEnumPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        GenerateEnumMacro.self
    ]
}
