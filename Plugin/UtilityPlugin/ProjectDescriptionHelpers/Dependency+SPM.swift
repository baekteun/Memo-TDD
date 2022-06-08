
import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let CombineMoya = TargetDependency.package(product: "CombineMoya")
    static let Quick = TargetDependency.package(product: "Quick")
    static let Nimble = TargetDependency.package(product: "Nimble")
    static let Needle = TargetDependency.package(product: "NeedleFoundation")
    static let Realm = TargetDependency.package(product: "Realm")
    static let RealmSwift = TargetDependency.package(product: "RealmSwift")
    static let Inject = TargetDependency.package(product: "Inject")
}

public extension Package {
    static let common: [Package] = [
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0")),
        .remote(url: "https://github.com/Quick/Quick.git", requirement: .upToNextMajor(from: "5.0.1")),
        .remote(url: "https://github.com/Quick/Nimble.git", requirement: .upToNextMajor(from: "10.0.0")),
        .remote(url: "https://github.com/uber/needle.git", requirement: .upToNextMajor(from: "0.18.1")),
        .remote(url: "https://github.com/realm/realm-swift.git", requirement: .upToNextMajor(from: "10.28.0")),
        .remote(url: "https://github.com/krzysztofzablocki/Inject.git", requirement: .upToNextMajor(from: "1.1.1"))
    ]
}
