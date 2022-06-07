import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "LocalDataSource",
    dependencies: [
        .Project.Module.Utility,
    ]
)
