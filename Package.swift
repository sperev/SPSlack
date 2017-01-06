import PackageDescription

let package = Package(
    name: "Slack",
    targets: [
        Target(name: "Slack"),
        Target(name: "SlackLog", dependencies: [.Target(name: "Slack")]),
        Target(name: "SlackLogTests", dependencies: ["SlackLog"]),
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 4),
        .Package(url: "https://github.com/sperev/request.git", majorVersion: 0, minor: 0)
    ]
)
