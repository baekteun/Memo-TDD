import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticFramework(
    name: "RemoteDataSource",
    dependencies: [
        .Project.Module.Utility,
    ]
)
