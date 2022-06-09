import ProjectDescription
import UtilityPlugin
import Foundation

public extension Project {
    static func staticLibrary(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        sources: SourceFilesList = .sources,
        dependencies: [TargetDependency] = [],
        hasDemoApp: Bool = false
    ) -> Project {
        return project(
            name: name,
            packages: packages,
            sources: sources,
            product: .staticLibrary,
            platform: platform,
            dependencies: dependencies,
            infoPlist: .default,
            hasDemoApp: hasDemoApp
        )
    }
    
    static func staticFramework(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        sources: SourceFilesList = .sources,
        dependencies: [TargetDependency] = [],
        hasDemoApp: Bool = false
    ) -> Project {
        return project(
            name: name,
            packages: packages,
            sources: sources,
            product: .staticFramework,
            platform: platform,
            dependencies: dependencies,
            infoPlist: .default,
            hasDemoApp: hasDemoApp
        )
    }
    
    static func framework(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        sources: SourceFilesList = .sources,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        hasDemoApp: Bool = false
    ) -> Project {
        return project(
            name: name,
            packages: packages,
            sources: sources,
            resources: resources,
            product: .framework,
            platform: platform,
            dependencies: dependencies,
            infoPlist: .default,
            hasDemoApp: hasDemoApp
        )
    }
    
}
let isForTest = (ProcessInfo.processInfo.environment["TUIST_TEST"] ?? "0") == "0" ? true : false
public extension Project {
    static func project(
        name: String,
        organizationName: String = Environment.organizationName,
        packages: [Package] = [],
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        demoResources: ResourceFileElements? = nil,
        product: Product,
        platform: Platform,
        deploymentTarget: DeploymentTarget? = Environment.deploymentTarget,
        dependencies: [TargetDependency] = [],
        infoPlist: InfoPlist,
        hasDemoApp: Bool = false
    ) -> Project {
        let scripts: [TargetScript] = isForTest ? [] : [.swiftLint]
        let appTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "\(organizationName).\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            scripts: scripts,
            dependencies: dependencies
        )
        let demoSource: SourceFilesList = ["Demo/Sources/**"]
        let demoSources: SourceFilesList = SourceFilesList(globs: sources.globs + demoSource.globs)
        
        let demoAppTarget = Target(
            name: "\(name)DemoApp",
            platform: platform,
            product: .app,
            bundleId: "\(organizationName).\(name)DemoApp",
            deploymentTarget: Environment.deploymentTarget,
            infoPlist: .extendingDefault(with: [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
                "ENABLE_TESTS": .boolean(true),
            ]),
            sources: demoSources,
            resources: ["Demo/Resources/**"],
            scripts: scripts,
            dependencies: [
                .target(name: name)
            ]
        )
        
        let testTargetDependencies: [TargetDependency] = hasDemoApp
        ? [.target(name: "\(name)DemoApp"), .SPM.Quick, .SPM.Nimble]
        : [.target(name: name), .SPM.Quick, .SPM.Nimble]
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: testTargetDependencies
        )
        
        let schemes: [Scheme] = hasDemoApp
        ? [.makeScheme(target: .debug, name: name), .makeDemoScheme(target: .debug, name: name)]
        : [.makeScheme(target: .debug, name: name)]
        
        let targets: [Target] = hasDemoApp
        ? [appTarget, testTarget, demoAppTarget]
        : [appTarget, testTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            targets: targets,
            schemes: schemes
        )
    }
}

extension Scheme {
    static func makeScheme(target: ProjectDeployTarget, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(["\(name)Tests"],
                                configuration: target.configurationName,
                                 options: .options(coverage: true, codeCoverageTargets: ["\(name)"])),
            runAction: .runAction(configuration: target.configurationName),
            archiveAction: .archiveAction(configuration: target.configurationName),
            profileAction: .profileAction(configuration: target.configurationName),
            analyzeAction: .analyzeAction(configuration: target.configurationName)
        )
    }
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
    static func makeDemoScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)DemoApp"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)DemoApp"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
    static func makeDemoScheme(target: ProjectDeployTarget, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)DemoApp"]),
            testAction: .targets(["\(name)Tests"],
                                 configuration: target.configurationName,
                                 options: .options(coverage: true, codeCoverageTargets: ["\(name)DemoApp"])),
            runAction: .runAction(configuration: target.configurationName),
            archiveAction: .archiveAction(configuration: target.configurationName),
            profileAction: .profileAction(configuration: target.configurationName),
            analyzeAction: .analyzeAction(configuration: target.configurationName)
        )
    }
}
