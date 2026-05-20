// swift-tools-version: 6.3
//
//  Package.swift
//  Halo
//
//  Created by Codex on 5/19/26.
//

import PackageDescription

let package = Package(
    name: "Halo",
    platforms: [
        .iOS(.v26),
    ],
    products: [
        .library(
            name: "Halo",
            targets: ["Halo"]
        ),
        .library(
            name: "HaloDemoUI",
            targets: ["HaloDemoUI"]
        ),
        .executable(
            name: "HaloDemo",
            targets: ["HaloDemo"]
        ),
    ],
    targets: [
        .target(
            name: "Halo"
        ),
        .target(
            name: "HaloDemoUI",
            dependencies: ["Halo"]
        ),
        .executableTarget(
            name: "HaloDemo",
            dependencies: ["HaloDemoUI"]
        ),
        .testTarget(
            name: "HaloTests",
            dependencies: ["Halo"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
