// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TunnelKit",
    platforms: [
        .macOS(.v10_15), .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TunnelKit",
            targets: [
                "TunnelKitCore",
                "TunnelKitAppExtension",
                "TunnelKitManager"
            ]
        ),
        .library(
            name: "TunnelKitIKE",
            targets: ["TunnelKitIKE"]
        ),
        .library(
            name: "TunnelKitOpenVPN",
            targets: ["TunnelKitOpenVPN"]
        ),
        .library(
            name: "TunnelKitLZO",
            targets: ["TunnelKitLZO"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver", .exact("1.9.5")),
        .package(url: "https://github.com/keeshux/openssl-apple", .exact("1.1.11200"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TunnelKitCore",
            dependencies: [
                "_TunnelKitUtils",
                "_TunnelKitCoreObjC",
                "SwiftyBeaver"]),
        .target(
            name: "_TunnelKitCoreObjC",
            dependencies: []),
        .target(
            name: "TunnelKitAppExtension",
            dependencies: [
                "TunnelKitCore",
                "SwiftyBeaver"]),
        .target(
            name: "TunnelKitManager",
            dependencies: [
                "TunnelKitCore"]),
        .target(
            name: "TunnelKitIKE",
            dependencies: [
                "TunnelKitCore",
                "TunnelKitManager"]),
        .target(
            name: "TunnelKitOpenVPN",
            dependencies: [
                "TunnelKitCore",
                "_TunnelKitOpenVPNObjC",
                "TunnelKitAppExtension",
                "TunnelKitManager"]),
        .target(
            name: "_TunnelKitOpenVPNObjC",
            dependencies: [
                "openssl-apple",
                "_TunnelKitCoreObjC"]),
        .target(
            name: "TunnelKitLZO",
            dependencies: [],
            exclude: [
                "lib/COPYING",
                "lib/Makefile",
                "lib/README.LZO",
                "lib/testmini.c"
            ]),
        .target(
            name: "_TunnelKitUtils",
            dependencies: []),
        .testTarget(
            name: "TunnelKitCoreTests",
            dependencies: [
                "TunnelKitCore"
            ]),
        .testTarget(
            name: "TunnelKitOpenVPNTests",
            dependencies: [
                "TunnelKitOpenVPN",
                "TunnelKitLZO"
            ],
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "TunnelKitLZOTests",
            dependencies: [
                "TunnelKitCore",
                "TunnelKitLZO"
            ]),
    ]
)
