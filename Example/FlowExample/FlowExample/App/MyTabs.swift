import Flow

enum MyTabs: FlowTabs, CaseIterable {
    case first
    case second

    var label: FlowTabLabel {
        switch self {
        case .first:  .init("First", .system("heart"))
        case .second: .init("Second", .system("star"))
        }
    }
}
