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

    // MARK: Codable conformance
    private enum CodingKeys: String, CodingKey {
        case selectedTab
    }

    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tab = try container.decode(TabOptions.Tabs.self, forKey: .selectedTab)
        self.init(tab: tab)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(selectedTab, forKey: .selectedTab)
    }
}
