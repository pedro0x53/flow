//
//  Coordinator.swift
//  Flow
//
//  Created by Pedro Sousa on 24/08/23.
//

import SwiftUI

public protocol StackCoordinator: Coordinator, FlowBuilder {
    var path: NavigationPath { get set }
    var breadcrumbs: [any Hashable] { get set }
    init(path: [any Hashable])
}

public extension StackCoordinator {
    func push<Flow: Hashable>(_ flow: Flow) {
        self.breadcrumbs.append(flow)
        self.path.append(flow)
    }

    func pop(_ k: Int = 1) {
        self.breadcrumbs.removeLast(k)
        self.path.removeLast(k)
    }

    func popToRoot() {
        self.breadcrumbs = []
        path = NavigationPath()
    }

    func pop<Flow: Hashable>(to flow: Flow) {
        guard let flowIndex = (self.breadcrumbs.firstIndex { $0.hashValue == flow.hashValue })
        else { return }
        self.pop(self.breadcrumbs.count - flowIndex - 1)
    }
}
