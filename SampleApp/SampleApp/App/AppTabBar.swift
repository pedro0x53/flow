//
//  AppTabBar.swift
//  Flow
//
//  Created by Pedro Sousa on 22/08/23.
//

import SwiftUI

struct AppTabBar: View {
    @ObservedObject var appCoordinator: AppCoordinator
    var dashboardCoordinator: DashboardCoordinator

    var body: some View {
        TabView(selection: $appCoordinator.selectedTab) {
            dashboardCoordinator
                .build()
                .navigationTitle("Dashboard")
                .tabItem {
                    Text("Dashboard")
                }
                .tag(AppCoordinator.Tabs.dashboard)

            CalendarView()
                .navigationTitle("Calendar")
                .tabItem {
                    Text("Calendar")
                }
                .tag(AppCoordinator.Tabs.calendar)

            SettingsView()
                .navigationTitle("Settings")
                .tabItem {
                    Text("Settings")
                }
                .tag(AppCoordinator.Tabs.settings)
        }
        .fullScreenCover(isPresented: $appCoordinator.shouldLogIn) {
            LoginCoordinator {
                self.appCoordinator.dismiss(sheet: .login)
            }
            .build()
        }
    }
}

struct AppTabBar_Previews: PreviewProvider {
    static var appCoordinator: AppCoordinator = .init()
    static var previews: some View {
        AppTabBar(appCoordinator: AppTabBar_Previews.appCoordinator,
                  dashboardCoordinator: .init(appCoordinator: AppTabBar_Previews.appCoordinator))
    }
}
