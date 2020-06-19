// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftLintConfigGenerator",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.39.0"),
        .package(url: "https://github.com/apple/swift-tools-support-core.git", from: "0.0.1"), // TODO: Adopt https://github.com/apple/swift-argument-parser
        .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
        .package(url: "https://github.com/JohnSundell/Files.git", from: "4.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftLintConfigGenerator",
            dependencies: ["SwiftLintConfigGeneratorCore"]),
        .target(name: "SwiftLintConfigGeneratorCore",
                dependencies: ["SwiftLintFramework", "SwiftToolsSupport", "Yams", "Files"]),
        .testTarget(
            name: "SwiftLintConfigGeneratorTests",
            dependencies: ["SwiftLintConfigGeneratorCore"]),
    ]
)
