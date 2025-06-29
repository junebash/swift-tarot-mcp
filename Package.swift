// swift-tools-version: 6.1
import PackageDescription

let package = Package(
  name: "swift-tarot-MCP",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    .executable(
      name: "swift-tarot-MCP",
      targets: ["TarotMCP"]
    ),
    .library(
      name: "TarotMCPCore",
      targets: ["TarotMCPCore"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/modelcontextprotocol/swift-sdk.git", from: "0.9.0"),
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.55.0"),
    .package(
      url: "https://github.com/pointfreeco/swift-snapshot-testing",
      .upToNextMajor(from: Version(1, 18, 4))
    )
  ],
  targets: [
    .target(
      name: "TarotMCPCore",
      dependencies: [
        .product(name: "MCP", package: "swift-sdk")
      ],
      resources: [
        .copy("Resources")
      ],
      swiftSettings: [
        .swiftLanguageMode(.v6),
      ]
    ),
    .executableTarget(
      name: "TarotMCP",
      dependencies: ["TarotMCPCore"],
      swiftSettings: [
        .swiftLanguageMode(.v6),
      ]
    ),
    .testTarget(
      name: "TarotMCPTests",
      dependencies: [
        "TarotMCPCore",
        .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing"),
      ],
      exclude: [
        "TarotMCP.xctestplan",
      ],
      swiftSettings: [
        .swiftLanguageMode(.v6),
      ]
    )
  ]
)
