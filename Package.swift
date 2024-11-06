// swift-tools-version: 5.4
import PackageDescription

let package = Package(
    name: "Toast",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Toast",
            targets: ["Toast"]),
    ],
    dependencies: [
        // This is where you add external dependencies.
        .package(url: "https://github.com/haiquy572001/toast-spm.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Toast",
            dependencies: [
                // Include the external dependency here if needed.
                .product(name: "toast-spm", package: "toast-spm")
            ],
            path: "Sources"
        ),
    ]
)
