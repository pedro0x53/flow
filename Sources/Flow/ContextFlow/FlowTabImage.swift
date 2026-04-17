public enum FlowTabImage: Equatable, Codable {
    case system(String)
    case named(String)

    public static func == (lhs: FlowTabImage, rhs: FlowTabImage) -> Bool {
        switch (lhs, rhs) {
        case let (.named(lhsName), .named(rhsName)):
                return lhsName == rhsName
        case let (.system(lhsName), .system(rhsName)):
                return lhsName == rhsName
        default:
            return false
        }
    }

    var name: String {
        switch self {
        case let .named(name):
            return name
        case let .system(name):
            return name
        }
    }
}
