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

let package = Package(
    name: "TapTapTipTapTimePreferences",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "TipTapTimePreferences",
            targets: ["TipTapTimePreferences"]
        ),
    ],
    targets: [
        .target(
            name: "TipTapTimePreferences",
            swiftSettings: [.unsafeFlags(libFlags)]
        ),
    ]
)
