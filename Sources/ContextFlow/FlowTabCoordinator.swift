import Foundation
import Observation
import SwiftUI

@Observable
public final class FlowTabCoordinator<TabOptions: FlowTabOptions>: Codable {
    public var selectedTab: TabOptions.Tabs

    public init(tab: TabOptions.Tabs) {
        self.selectedTab = tab
    }

    public func select(tab: TabOptions.Tabs) {
        self.selectedTab = tab
    }
}
