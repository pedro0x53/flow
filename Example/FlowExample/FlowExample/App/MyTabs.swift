import SwiftUI
import Flow

enum MyTabs: String, CaseIterable, FlowTabs {
    case first
    case second

    static var tabs: [MyTabs] { MyTabs.allCases }

    var title: String {
        switch self {
        case .first:
            return "First"
        case .second:
            return "Second"
        }
    }

    var image: FlowTabImage {
        switch self {
        case .first:
            return .system("star")
        case .second:
            return .system("heart")
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .first:
            FirstTab()
        case .second:
            SecondTab()
        }
    }
}
