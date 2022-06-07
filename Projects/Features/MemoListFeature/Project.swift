import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "MemoListFeature",
    dependencies: [
        .Project.Features.CommonFeature
    ],
    hasDemoApp: true
)
