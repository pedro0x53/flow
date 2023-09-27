//
//  ProjectEditorStackCoordinator.swift
//  Flow
//
//  Created by Pedro Sousa on 22/08/23.
//

import SwiftUI
import Flow

class ProjectCoordinator: Presented, StackCoordinator {
    let id: UUID = UUID()

    @Published var path: NavigationPath = NavigationPath()
    var breadcrumbs: [any Hashable] = []

    var onDismiss: (() -> Void)?

    required init(path: [any Hashable]) {
        self.onDismiss = nil
        self.breadcrumbs = path
        path.forEach { self.path.append($0) }
    }

    required init(onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss
        self.path = NavigationPath()
    }

    init(path: [any Hashable],
         onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss
        self.breadcrumbs = path
        path.forEach { self.path.append($0) }
    }

    @ViewBuilder func build() -> some View {
        ProjectEditorView(router: self)
    }

    func dismiss() {
        self.onDismiss?()
    }
}

extension ProjectCoordinator {
    enum Coordinates: String, Hashable {
        case additional

        func hash(into hasher: inout Hasher) {
            hasher.combine(self.rawValue)
        }
    }
}

extension ProjectCoordinator {
    static func == (lhs: ProjectCoordinator, rhs: ProjectCoordinator) -> Bool {
        lhs.id == rhs.id
    }
}
