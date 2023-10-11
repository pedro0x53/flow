//
//  DashboardRouter.swift
//  Flow
//
//  Created by Pedro Sousa on 22/08/23.
//

import SwiftUI
import Flow

enum DashboardSheets: Hashable {
    case projectEditor
}

class DashboardCoordinator: StackCoordinator {
    let id: UUID = UUID()

    weak var appCoordinator: AppCoordinator?
    var projectEditorCoordinator: ProjectCoordinator
    var videoRouter: VideoRouter

    @Published var isPresentingProjectEditor: Bool = false
    @Published var path: NavigationPath = NavigationPath()

    required init(path: NavigationPath) {
        fatalError("Use the conveniece initializer init(appCoordinator:path:isPresentingProjectEditor:)")
    }

    init(appCoordinator: AppCoordinator? = nil,
         path: NavigationPath = .init(),
         isPresentingProjectEditor: Bool = false) {
        self.appCoordinator = appCoordinator
        self.isPresentingProjectEditor = isPresentingProjectEditor
        self.path = path

        let projectEditor = ProjectCoordinator()
        self.projectEditorCoordinator = projectEditor

        let videoRouter = VideoRouter()
        self.videoRouter = videoRouter

        self.videoRouter.parent = self

        self.projectEditorCoordinator.onDismiss {
            self.dismiss(sheet: .projectEditor)
        }
    }

    @ViewBuilder func build() -> some View {
        DashboardView(coordinator: self)
    }

    func logOut() {
        self.popToRoot()
        appCoordinator?.logOut()
    }
}

extension DashboardCoordinator: Presenter {
    func present(sheet: DashboardSheets) {
        self.isPresentingProjectEditor = true
    }

    func dismiss(sheet: DashboardSheets) {
        self.isPresentingProjectEditor = false
    }
}

extension DashboardCoordinator {
    static func == (lhs: DashboardCoordinator, rhs: DashboardCoordinator) -> Bool {
        lhs.id == rhs.id
    }
}
