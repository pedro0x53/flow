//
//  Router.swift
//  Flow
//
//  Created by Pedro Sousa on 31/08/23.
//

import Foundation

public protocol Router: Coordinator, FlowBuilder {
    associatedtype Parent: StackCoordinator
    var parent: Parent? { get set }
    init(parent: Parent?)
}

public extension Router {
    func push<Flow: Hashable>(_ flow: Flow) {
        self.parent?.push(flow)
    }

    func pop(_ amount: Int = 1) {
        self.parent?.pop(amount)
    }

    func popToRoot() {
        self.parent?.popToRoot()
    }
}
