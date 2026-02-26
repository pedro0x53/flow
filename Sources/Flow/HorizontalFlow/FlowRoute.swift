import Foundation
import SwiftUI

// MARK: ViewRoute - Convenience Protocol that blends View and Route
public protocol FlowRoute: Hashable {
    associatedtype Destination: View
    @ViewBuilder
    var destination: Destination { get }
}

// MARK: Codable+Route - If the Route is also a Codable
public extension FlowRoute where Self: Codable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (try? JSONEncoder().encode(lhs)) == (try? JSONEncoder().encode(rhs))
    }

    func hash(into hasher: inout Hasher) {
        if let data = try? JSONEncoder().encode(self) {
            data.withUnsafeBytes { hasher.combine(bytes: $0) }
        } else {
            hasher.combine(String(describing: self))
        }
    }
}

// MARK: View+Route - If the Route is also a View, the default destination is itself
public extension FlowRoute where Self: View {
    @ViewBuilder
    var destination: Self { self }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return String(describing: lhs) == String(describing: rhs)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: self))
    }
}

// MARK: View+Codable+Route - If the Route is Codable and a View
public extension FlowRoute where Self: Codable, Self: View {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (try? JSONEncoder().encode(lhs)) == (try? JSONEncoder().encode(rhs))
    }

    func hash(into hasher: inout Hasher) {
        if let data = try? JSONEncoder().encode(self) {
            data.withUnsafeBytes { hasher.combine(bytes: $0) }
        } else {
            hasher.combine(String(describing: self))
        }
    }
}

public protocol FlowView: FlowRoute, View {}

public extension View {
    func destination<R: FlowRoute>(_ route: R.Type) -> some View {
        self.navigationDestination(for: R.self) { route in
            route.destination
        }
    }
}
