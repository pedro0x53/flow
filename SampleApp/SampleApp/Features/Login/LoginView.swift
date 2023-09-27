//
//  LoginView.swift
//  Flow
//
//  Created by Pedro Sousa on 22/08/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var router: LoginCoordinator

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Button("Push to forget Password") {
                    router.push(LoginCoordinator.Coordinates.forgetPassword)
                }

                Button("Go to Dashboard") {
                    router.dismiss()
                }
            }
            .navigationTitle("Login")
            .navigationDestination(for: LoginCoordinator.Coordinates.self) { coordinate in
                switch coordinate {
                case .forgetPassword:
                    ForgetPasswordView()
                }
            }
        }
    }
}

struct LoginViewPreview: PreviewProvider {
    static var previews: some View {
        LoginCoordinator().build()
    }
}
