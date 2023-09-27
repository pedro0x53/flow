//
//  SampleAppApp.swift
//  SampleApp
//
//  Created by Pedro Sousa on 27/09/23.
//

import SwiftUI

@main
struct SampleAppApp: App {
    @StateObject var appCoordinator: AppCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            AppCoordinator().build()
        }
    }
}
