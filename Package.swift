// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tidy-sub",
    products: [
        .executable(
            name: "tidy",
            targets: ["tidy"]
        ),
        .library(
            name: "tidysub",
            targets: ["tidysub"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1"),
        .package(url: "https://github.com/Apollonyan/subtitle.git", .branch("master")),
        .package(url: "https://github.com/onevcat/Rainbow.git", from: "3.1.4"),
    ],
    targets: [
        .target(
            name: "tidy",
            dependencies: ["tidysub"]),
        .target(
            name: "tidysub",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "srt", package: "subtitle"),
                "Rainbow"
        ]),
        .testTarget(
            name: "tidysubTests",
            dependencies: ["tidysub"]),
    ]
)
