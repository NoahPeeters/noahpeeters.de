// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "noahpeeters.de",
    platforms: [
       .macOS(.v11)
    ],
    products: [
        .executable(name: "Frontend", targets: ["Frontend"]),
        .executable(name: "Backend", targets: ["Backend"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
        .package(name: "Tokamak", url: "https://github.com/TokamakUI/Tokamak", from: "0.6.1"),
        .package(url: "https://github.com/OpenCombine/OpenCombine.git", from: "0.12.0")
    ],
    targets: [
        .target(
            name: "Helper",
            dependencies: [
                .product(name: "OpenCombine", package: "OpenCombine")
            ]),
        .target(name: "API"),
        .target(
            name: "FrontendLib",
            dependencies: [
                .product(name: "TokamakShim", package: "Tokamak"),
                .target(name: "Helper"),
                .target(name: "API")
            ]),
        .target(
            name: "Frontend",
            dependencies: [
                .target(name: "FrontendLib")
            ]),
        .target(
            name: "BackendLib",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Leaf", package: "leaf"),
                .target(name: "Helper"),
                .target(name: "API")
            ],
            swiftSettings: [
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]),
        .target(
            name: "Backend",
            dependencies: [
                .target(name: "BackendLib")
            ])
    ]
)
