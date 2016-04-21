import PackageDescription

let package = Package(
    name: "RequestSession",
    dependencies: [
      .Package(url: "https://github.com/neonichu/Requests", majorVersion: 0),
    ],
    testDependencies: [
      .Package(url: "https://github.com/neonichu/spectre-build.git", majorVersion: 0),
    ]
)
