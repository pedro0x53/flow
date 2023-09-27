//
//  AppCoordinator.swift
//  Flow
//
//  Created by Pedro Sousa on 22/08/23.
//

import SwiftUI
import Flow

class AppCoordinator: TabCoordinator, Presenter {
    let id: UUID = UUID()

    @Published var selectedTab: AppCoordinator.Tabs
    @Published var shouldLogIn: Bool

    var dashboardCoordinator: DashboardCoordinator

    required init(selectedTab: AppCoordinator.Tabs) {
        self.shouldLogIn = true
        self.selectedTab = selectedTab

        self.dashboardCoordinator = .init()
        self.dashboardCoordinator.appCoordinator = self
    }

    init(isLoggedIn: Bool = false,
         selectedTab: AppCoordinator.Tabs = .dashboard) {
        self.shouldLogIn = !isLoggedIn
        self.selectedTab = selectedTab

        self.dashboardCoordinator = .init()
        self.dashboardCoordinator.appCoordinator = self
    }

    func select(tab: AppCoordinator.Tabs) {
        self.selectedTab = tab
    }

    func logOut() {
        self.shouldLogIn = true
    }

    @ViewBuilder func build() -> some View {
        AppTabBar(appCoordinator: self,
                  dashboardCoordinator: .init(appCoordinator: self))
    }
}

extension AppCoordinator {
    enum Sheets: String {
        case login
    }

    func present(sheet: AppCoordinator.Sheets) {
        self.shouldLogIn = true
    }

    func dismiss(sheet: AppCoordinator.Sheets) {
        self.shouldLogIn = false
    }
}

extension AppCoordinator {
    static func == (lhs: AppCoordinator, rhs: AppCoordinator) -> Bool {
        lhs.id == rhs.id
    }
}

extension AppCoordinator {
    enum Tabs: String, Hashable {
        case dashboard
        case calendar
        case settings
    }
}
