import SwiftUI

public struct FlowTabView<Options: FlowTabOptions, Content: TabContent>: View {
    @Bindable var tabCoordinator: FlowTabCoordinator<Options>
    var content: () -> Content

    public init(tabCoordinator: FlowTabCoordinator<Options>,
                @TabContentBuilder<Options.Tab> content: @escaping () -> Content
    ) {
        self.tabCoordinator = tabCoordinator
        self.content = content
    }

    public var body: some View {
        TabView(selection: $tabCoordinator.selectedTab, content: content)
    }
}
