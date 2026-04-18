import Foundation
import Observation
import SwiftUI

@Observable
public final class FlowTabCoordinator<Options: FlowTabOptions>: Codable {
    public var selectedTab: Options.Tab

    public init(tab: Options.Tab) {
        self.selectedTab = tab
    }

    public func select(tab: Options.Tab) {
        self.selectedTab = tab
    }
}

extension FlowTabCoordinator {
    // MARK: Codable conformance
    private enum CodingKeys: String, CodingKey {
        case selectedTab
    }

    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tab = try container.decode(Options.Tab.self, forKey: .selectedTab)
        self.init(tab: tab)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(selectedTab, forKey: .selectedTab)
    }
}
