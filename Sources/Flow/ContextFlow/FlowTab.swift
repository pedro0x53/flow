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

public extension FlowTab {
    @TabContentBuilder<Self>
    func callAsFunction<Content: View>(
        @ViewBuilder content: @escaping () -> Content
    ) -> some TabContent<Self> {
        switch label.image {
        case .system(let name):
            Tab(title, systemImage: name, value: self, content: content)
        case .named(let name):
            Tab(title, image: name, value: self, content: content)
        }
    }
}

public protocol FlowTabs: FlowTab, FlowTabOptions {}
