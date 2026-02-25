import SwiftUI

// MARK: Convenient way to erase the NavigationPath from the CoordinatorSchema protocol
public protocol FlowPath {
    var isEmpty: Bool { get }
    var count: Int { get }

    init()

    mutating func append<V>(_ value: V) where V : Hashable
    mutating func removeLast(_ k: Int)
}

extension NavigationPath: FlowPath {}
