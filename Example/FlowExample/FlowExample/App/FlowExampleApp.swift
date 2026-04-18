import SwiftUI
import Flow

@main
struct FlowExampleApp: App {
    @State var tabCoordinator = FlowTabCoordinator<MyTabs>(tab: .first)

    var body: some Scene {
        WindowGroup {
            FlowTabView(tabCoordinator: tabCoordinator) {
                MyTabs.first {
                    FirstTab()
                }

                MyTabs.second {
                    SecondTab()
                }
            }
        }
    }
}
