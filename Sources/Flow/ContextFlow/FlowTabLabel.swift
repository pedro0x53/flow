public struct FlowTabLabel: Equatable, Codable {
    public let title: String
    public let image: FlowTabImage

    public init(_ title: String, _ image: FlowTabImage) {
        self.title = title
        self.image = image
    }

    public static func == (lhs: FlowTabLabel, rhs: FlowTabLabel) -> Bool {
        lhs.title == rhs.title && lhs.image == rhs.image
    }
}
