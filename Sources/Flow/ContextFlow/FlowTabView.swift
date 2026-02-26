import SwiftUI

public struct FlowTabView<TabOptions: FlowTabOptions>: View {
    @State var tabCoordinator: FlowTabCoordinator<TabOptions>

    public init(tabCoordinator: FlowTabCoordinator<TabOptions>) {
        self.tabCoordinator = tabCoordinator
    }

    public var body: some View {
        let tabs = TabOptions.tabs
        return TabView(selection: $tabCoordinator.selectedTab) {
            ForEach(Array(zip(tabs.indices, tabs)), id: \.0) { _, tab in
                switch tab.image {
                case .system(let name):
                    Tab(tab.title, systemImage: name, value: tab) {
                        tab.destination
                            .environment(tabCoordinator)
                    }
                case .named(let name):
                    Tab(tab.title, image: name, value: tab) {
                        tab.destination
                            .environment(tabCoordinator)
                    }
                }
            }
        }
    }
}
