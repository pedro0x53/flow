import Foundation
import SwiftUI

public protocol FlowRoute: Hashable, Codable {}

public extension FlowRoute {
    public func callAsFunction<Label: View, Destination: View>(
        @ViewBuilder _ label: @escaping () -> Label,
        @ViewBuilder destination: @escaping () -> Destination
    ) -> some View {
        NavigationLink(destination: destination, label: label)
    }

    public func callAsFunction<Label: View>(
        @ViewBuilder _ label: @escaping () -> Label
    ) -> some View {
        NavigationLink(value: self, label: label)
    }

    public func callAsFunction(
        _ title: String,
    ) -> some View {
        NavigationLink(title, value: self)
    }
}

public extension FlowRoute {
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
