import SwiftUI

public enum FlowTabImage: Codable {
    case system(String)
    case named(String)
}

public protocol FlowTab: Hashable, Sendable, Codable {
    associatedtype Destination: View
    @ViewBuilder
    var destination: Destination { get }

    var title: String { get }
    var image: FlowTabImage { get }
}

public protocol FlowTabOptions: Codable {
    associatedtype Tabs: FlowTab
    static var tabs: [Tabs] { get }
}

public protocol FlowTabs: FlowTab, FlowTabOptions {}
