import PackageDescription

let package = Package(
    name: "PaystackProvider",
    dependencies: [
        .Package(url: "https:github.com/vapor/vapor.git", majorVersion: 2)
    ]
)
