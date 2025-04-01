// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "GenerateEnum",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [
        .library(
            name: "GenerateEnum",
            targets: ["GenerateEnum"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "601.0.0"),
    ],
    targets: [
        .macro(
            name: "GenerateEnumMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(
            name: "GenerateEnum",
            dependencies: ["GenerateEnumMacros"]
        ),
        .target(
            name: "ObjCClasses",
            path: "Tests/ObjCClasses", // Указываем папку с ObjC-кодом
            publicHeadersPath: "."
        ),
        .testTarget(
            name: "GenerateEnumTests",
            dependencies: ["GenerateEnum", "ObjCClasses"], // Добавляем ObjCClasses как зависимость
            cSettings: [
                .headerSearchPath(".")
            ]
        )
    ]
)
