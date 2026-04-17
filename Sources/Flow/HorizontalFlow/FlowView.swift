import SwiftUI

public protocol FlowView: FlowRoute, View {}

public extension View {
    func destination<R: FlowRoute>(_ route: R.Type) -> some View {
        self.navigationDestination(for: R.self) { route in
            route.destination
        }
    }
}
