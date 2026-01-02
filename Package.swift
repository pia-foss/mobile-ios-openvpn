// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "TunnelKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "TunnelKit",
            targets: ["TunnelKit"]
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
            name: "TunnelKitOpenVPNAppExtension",
            targets: ["TunnelKitOpenVPNAppExtension"]
        ),
        .library(
            name: "TunnelKitLZO",
            targets: ["TunnelKitLZO"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.8.0"),
        .package(url: "git@github.com:pia-foss/ios-openssl.git", branch: "main")
    ],
    targets: [
        .target(
            name: "TunnelKit",
            dependencies: [
                "TunnelKitCore",
                "TunnelKitManager"
            ]
        ),
        .target(
            name: "TunnelKitCore",
            dependencies: [
                "__TunnelKitUtils",
                "CTunnelKitCore",
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .target(
            name: "TunnelKitManager",
            dependencies: [
                "TunnelKitCore"
            ]
        ),
        .target(
            name: "TunnelKitAppExtension",
            dependencies: [
                "TunnelKitCore"
            ]
        ),
        .target(
            name: "TunnelKitIKE",
            dependencies: [
                "TunnelKitManager"
            ]
        ),
        .target(
            name: "TunnelKitOpenVPN",
            dependencies: [
                "TunnelKitOpenVPNCore",
                "TunnelKitOpenVPNManager"
            ]
        ),
        .target(
            name: "TunnelKitOpenVPNCore",
            dependencies: [
                "TunnelKitCore",
                "CTunnelKitOpenVPNCore",
                "CTunnelKitOpenVPNProtocol" // FIXME: remove dependency on TLSBox
            ]
        ),
        .target(
            name: "TunnelKitOpenVPNManager",
            dependencies: [
                "TunnelKitManager",
                "TunnelKitOpenVPNCore"
            ]
        ),
        .target(
            name: "TunnelKitOpenVPNProtocol",
            dependencies: [
                "TunnelKitOpenVPNCore",
                "CTunnelKitOpenVPNProtocol"
            ]
        ),
        .target(
            name: "TunnelKitOpenVPNAppExtension",
            dependencies: [
                "TunnelKitAppExtension",
                "TunnelKitOpenVPNCore",
                "TunnelKitOpenVPNManager",
                "TunnelKitOpenVPNProtocol"
            ]
        ),
        .target(
            name: "TunnelKitLZO",
            exclude: [
                "lib/COPYING",
                "lib/Makefile",
                "lib/README.LZO",
                "lib/testmini.c"
            ]
        ),
        .target(
            name: "CTunnelKitCore"
        ),
        .target(
            name: "CTunnelKitOpenVPNCore"
        ),
        .target(
            name: "CTunnelKitOpenVPNProtocol",
            dependencies: [
                "CTunnelKitCore",
                "CTunnelKitOpenVPNCore",
                .product(name: "openssl-apple", package: "ios-openssl")
            ]
        ),
        .target(
            name: "__TunnelKitUtils"
        ),
        .testTarget(
            name: "TunnelKitCoreTests",
            dependencies: [
                "TunnelKitCore"
            ]
        ),
        .testTarget(
            name: "TunnelKitOpenVPNTests",
            dependencies: [
                "TunnelKitOpenVPNCore",
                "TunnelKitOpenVPNAppExtension",
                "TunnelKitLZO"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "TunnelKitLZOTests",
            dependencies: [
                "TunnelKitCore",
                "TunnelKitLZO"
            ]
        )
    ]
)
