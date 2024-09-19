// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Windows)
let systemLibraries: [Target] = [
    .systemLibrary(
        name: "Clibgraphviz"
    )
]
#else
let systemLibraries: [Target] = [
    .systemLibrary(
        name: "Clibgraphviz",
        pkgConfig: "libcgraph",
        providers: [
          .brew(["graphviz"]),
          .apt(["graphviz-dev"]),
        ]
    ),
]
#endif

let package = Package(
    name: "swift-graphviz",
    platforms: [.macOS(.v10_15)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "GraphViz",
            targets: ["GraphViz"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/swiftlang/swift-docc-plugin.git", from: "1.1.0"),
    ],
    targets: systemLibraries + [
        .target(
            name: "GraphViz",
            dependencies: ["Clibgraphviz"]
        ),
        .testTarget(
            name: "GraphVizTests",
            dependencies: ["GraphViz"]
        ),
    ]
)
