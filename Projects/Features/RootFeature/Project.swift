import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "RootFeature",
    dependencies: [
        .Project.Features.MemoListFeature
    ]
)
