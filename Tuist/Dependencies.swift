import ProjectDescription

let dependencies = Dependencies(
    carthage: [
        .github(path: "realm/realm-swift", requirement: .upToNext("10.28.0"))
    ],
    swiftPackageManager: [
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0")),
        .remote(url: "https://github.com/Quick/Quick.git", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/Quick/Nimble.git", requirement: .upToNextMajor(from: "9.0.0")),
        .remote(url: "https://github.com/uber/needle.git", requirement: .upToNextMajor(from: "0.18.1"))
    ],
    platforms: [.iOS]
)
