
import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let CombineMoya = TargetDependency.external(name: "CombineMoya")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let Quick = TargetDependency.external(name: "Quick")
    static let Nimble = TargetDependency.external(name: "Nimble")
}
