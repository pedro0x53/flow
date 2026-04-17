import SwiftUI

public protocol FlowTab: Hashable, Codable {
    var label: FlowTabLabel { get }
}

public extension FlowTab {
    var title: String { label.title }
    var image: String { label.image.name }
}

extension Tab where Value: FlowTab, Label == DefaultTabLabel, Content: View {
    public init(_ tab: Value, @ViewBuilder content: () -> Content) {
        self.init(
            tab.title,
            systemImage: tab.image,
            value: tab,
            content: content
        )
    }
}

public protocol FlowTabs: FlowTab, FlowTabOptions {}
