// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 6.0
import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "GenerateEnum",
    platforms: [.macOS(.v12), .iOS(.v15)], // Минимальная версия Swift Macros API
    products: [
        .library(
            name: "GenerateEnum",
            targets: ["GenerateEnum"]
        ),
        .executable(
            name: "GenerateEnumClient",
            targets: ["GenerateEnumClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
    ],
    targets: [
        // Макросная реализация
        .macro(
            name: "GenerateEnumMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        // Библиотека с объявлением макроса
        .target(
            name: "GenerateEnum",
            dependencies: ["GenerateEnumMacros"]
        ),

        // Тестовый клиент макроса
        .executableTarget(
            name: "GenerateEnumClient",
            dependencies: ["GenerateEnum"]
        ),

        // Плагин компилятора (должен быть в `Plugins/`)
        .plugin(
            name: "GenerateEnumPlugin",
            capability: .buildTool(),
            dependencies: ["GenerateEnumMacros"]
        ),
    ]
)
