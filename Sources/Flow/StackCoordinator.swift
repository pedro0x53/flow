//
//  Coordinator.swift
//  Flow
//
//  Created by Pedro Sousa on 24/08/23.
//

import SwiftUI

public protocol StackCoordinator: Coordinator, FlowBuilder {
    var path: NavigationPath { get set }
    init(path: NavigationPath)
}

public extension StackCoordinator {
    func push<Flow: Hashable>(_ flow: Flow) {
        self.path.append(flow)
    }

    func pop(_ amount: Int = 1) {
        self.path.removeLast(amount)
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
