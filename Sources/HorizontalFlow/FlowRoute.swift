import Foundation
import SwiftUI

// MARK: ViewRoute - Convenience Protocol that blends View and Route
public protocol FlowRoute: Hashable, Codable {
    associatedtype Destination: View
    @ViewBuilder
    var destination: Destination { get }
}

// MARK: View+Route - If the Route is also a View, the destination is itself
public extension FlowRoute where Self: View {
    @ViewBuilder
    var destination: Self { self }

    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (try? JSONEncoder().encode(lhs), try? JSONEncoder().encode(rhs)) {
        case let (lhsData?, rhsData?):
            return lhsData == rhsData
        case (nil, nil):
            return String(describing: lhs) == String(describing: rhs)
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        if let data = try? JSONEncoder().encode(self) {
            data.withUnsafeBytes { hasher.combine(bytes: $0) }
        } else {
            hasher.combine(String(describing: self))
        }
    }
}

// MARK: ViewRoute - Convenience Protocol that blends View and Route
public protocol FlowView: View, FlowRoute {}

public extension View {
    func destination<R: FlowRoute>(_ route: R.Type) -> some View {
        self.navigationDestination(for: R.self) { route in
            route.destination
        }
    }
}
