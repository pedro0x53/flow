public protocol FlowTabOptions: Codable {
    associatedtype Tab: FlowTab
    static var tabs: [Tab] { get }
}

public extension FlowTabOptions where Self: CaseIterable, Self.Tab == Self.AllCases.Element {
    static var tabs: [Self.Tab] { Array(Self.allCases) }
}