import ProjectDescription

public enum Environment {
    public static let appName = "MemoTDD"
    public static let targetName = "MemoTDD"
    public static let targetDevName = "Dev\(targetName)"
    public static let targetTestName = "\(targetName)Tests"
    public static let organizationName = "baegteun"
    public static let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "15.0", devices: [.iphone, .ipad])
    public static let platform = Platform.iOS
    public static let baseSetting: SettingsDictionary = .codeSign
}
