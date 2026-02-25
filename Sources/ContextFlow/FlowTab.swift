import SwiftUI

public enum FlowTabImage: Codable {
    case system(String)
    case named(String)
}

public protocol FlowTab: FlowRoute, Sendable, Codable {
    var title: String { get }
    var image: FlowTabImage { get }
}

public protocol FlowTabOptions: Codable {
    associatedtype Tabs: FlowTab
    static var tabs: [Tabs] { get }
}

public protocol FlowTabs: FlowTab, FlowTabOptions {}
