// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "register_devices_for_txt",
    products: [
        .executable(name: "register_devices_for_txt", targets: ["register_devices_for_txt"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git", from: "0.9.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.0.2")
    ],
    targets: [
        .target(
            name: "register_devices_for_txt",
            dependencies: ["Commander", "Files"]),
        .testTarget(
            name: "register_devices_for_txtTests",
            dependencies: ["register_devices_for_txt", "Commander", "Files"]),
    ]
)
