//
//  TabCoordinator.swift
//  Flow
//
//  Created by Pedro Sousa on 24/08/23.
//

import Foundation

public protocol TabCoordinator: ObservableObject, AnyObject {
    associatedtype Tabs: Hashable

    var selectedTab: Tabs { get set }

    init(selectedTab: Tabs)

    func select(tab: Tabs)
}

public extension TabCoordinator {
    func select(tab: Tabs) {
        self.selectedTab = tab
    }
}
