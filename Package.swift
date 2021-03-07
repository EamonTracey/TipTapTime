// swift-tools-version:5.2

import PackageDescription
import Foundation

let theosPath = ProcessInfo.processInfo.environment["THEOS"]!

let libFlags: [String] = [
    "-F\(theosPath)/vendor/lib",
    "-F\(theosPath)/lib",
    "-I\(theosPath)/vendor/include",
    "-I\(theosPath)/include"
]

let cFlags: [String] = libFlags + [
    "-Wno-unused-command-line-argument",
    "-Qunused-arguments",
]

let package = Package(
    name: "TipTapTime",
    platforms: [.iOS("13.0")],
    products: [
        .library(
            name: "TipTapTime",
            targets: ["TipTapTime"]
        ),
    ],
    targets: [
        .target(
            name: "TipTapTimeC",
            cSettings: [.unsafeFlags(cFlags)]
        ),
        .target(
            name: "TipTapTime",
            dependencies: ["TipTapTimeC"],
            swiftSettings: [.unsafeFlags(libFlags)]
        ),
    ]
)
