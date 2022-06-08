import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "ThirdPartyLib",
    packages: Package.common,
    dependencies: [
        .SPM.CombineMoya,
        .SPM.RealmSwift,
        .SPM.Realm,
        .SPM.Inject,
        .SPM.Needle,
    ]
)
