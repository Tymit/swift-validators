// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-validators",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "Validators",
      targets: [
        "Validators"
      ]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Validators",
      dependencies: [
      ]
    ),
    .testTarget(
      name: "ValidatorsTests",
      dependencies: [
        "Validators"
      ]
    ),
  ]
)
