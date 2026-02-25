import SwiftUI
import Flow

@main
struct FlowExampleApp: App {
    let tabCoordinator = FlowTabCoordinator<MyTabs>(tab: .first)

    var body: some Scene {
        WindowGroup {
            FlowTabView(tabCoordinator: tabCoordinator)
        }
    }
}
