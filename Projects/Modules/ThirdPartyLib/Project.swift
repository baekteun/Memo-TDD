import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "ThirdPartyLib",
    dependencies: [
        .SPM.CombineMoya,
        .SPM.Swinject,
    ]
)
