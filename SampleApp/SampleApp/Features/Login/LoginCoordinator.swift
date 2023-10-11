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

    @Published var path: NavigationPath

    var onDismiss: (() -> Void)?
    
    required init(path: NavigationPath) {
        fatalError("Use designated initializer init(path:onDismiss:)")
    }

    required init(onDismiss: (() -> Void)?) {
        fatalError("Use designated initializer init(path:onDismiss:)")
    }

    init(path: NavigationPath = .init(),
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
    enum Coordinates: String, Hashable, Identifiable {
        case forgetPassword
    }
}

extension LoginCoordinator {
    static func == (lhs: LoginCoordinator, rhs: LoginCoordinator) -> Bool {
        lhs.id == rhs.id
    }
}
