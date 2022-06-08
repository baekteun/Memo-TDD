import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "ThirdPartyLib",
    dependencies: [
        .SPM.Alamofire,
        .SPM.Moya,
        .SPM.CombineMoya,
        .SPM.Needle,
        .SPM.RealmSwift,
        .SPM.Inject,
        .SPM.Realm
    ]
)
