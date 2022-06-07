
import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let Alamofire = TargetDependency.external(name: "Alamofire")
    static let Moya = TargetDependency.external(name: "Moya")
    static let CombineMoya = TargetDependency.external(name: "CombineMoya")
    static let Quick = TargetDependency.external(name: "Quick")
    static let Nimble = TargetDependency.external(name: "Nimble")
    static let Needle = TargetDependency.external(name: "NeedleFoundation")
    static let Realm = TargetDependency.external(name: "Realm")
    static let RealmSwift = TargetDependency.external(name: "RealmSwift")
    static let Inject = TargetDependency.external(name: "Inject")
}
