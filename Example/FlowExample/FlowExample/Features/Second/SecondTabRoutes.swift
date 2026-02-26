import Flow
import SwiftUI

enum SecondTabRoutes: Int, FlowRoute {
    case viewA
    case viewB

    var destination: some View {
        switch self {
        case .viewA:
            ViewA()
        case .viewB:
            ViewB()
        }
    }
}
