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

    var onDismiss: (() -> Void)?

    required init(path: NavigationPath) {
        fatalError("Use designated initializer init(path:onDismiss:)")
    }

    required init(onDismiss: (() -> Void)?) {
        fatalError("Use designated initializer init(path:onDismiss:)")
    }

    init(path: NavigationPath = .init(),
         onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss
        self.path = path
    }

    @ViewBuilder func build() -> some View {
        ProjectEditorView(router: self)
    }

    func dismiss() {
        self.onDismiss?()
    }
}

extension ProjectCoordinator {
    enum Coordinates: String, Hashable, Identifiable {
        case additional
    }
}

extension ProjectCoordinator {
    static func == (lhs: ProjectCoordinator, rhs: ProjectCoordinator) -> Bool {
        lhs.id == rhs.id
    }
}
