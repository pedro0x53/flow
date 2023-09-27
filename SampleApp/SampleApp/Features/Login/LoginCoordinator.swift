//
//  LoginCoordinator.swift
//  Flow
//
//  Created by Pedro Sousa on 22/08/23.
//

import SwiftUI
import Flow

class LoginCoordinator: StackCoordinator, Presented {
    let id: UUID = UUID()

    @Published var path: NavigationPath = NavigationPath()
    var breadcrumbs: [any Hashable] = []

    var onDismiss: (() -> Void)?
    
    required init(path: [any Hashable]) {
        self.breadcrumbs = path
        path.forEach { self.path.append($0) }
        self.onDismiss = nil
    }

    required init(onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss
    }

    init(path: NavigationPath = NavigationPath(),
         onDismiss: (() -> Void)? = nil) {
        self.path = path
        self.onDismiss = onDismiss
    }

    func build() -> some View {
        LoginView(router: self)
    }

    func dismiss() {
        self.onDismiss?()
    }
}

extension LoginCoordinator {
    enum Coordinates: String, Hashable {
        case forgetPassword
    }
}

extension LoginCoordinator {
    static func == (lhs: LoginCoordinator, rhs: LoginCoordinator) -> Bool {
        lhs.id == rhs.id
    }
}
