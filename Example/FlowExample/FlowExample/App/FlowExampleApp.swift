import SwiftUI
import Flow

@main
struct FlowExampleApp: App {
    @State var tabCoordinator = FlowTabCoordinator<MyTabs>(tab: .first)

    var body: some Scene {
        WindowGroup {
            FlowTabView(tabCoordinator: tabCoordinator) {
                Tab(MyTabs.first) {
                    FirstTab()
                }

                Tab(MyTabs.second) {
                    FirstTab()
                }
            }
        }
    }
}
