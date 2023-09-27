//
//  ForgetPasswordView.swift
//  Flow
//
//  Created by Pedro Sousa on 22/08/23.
//

import SwiftUI

struct ForgetPasswordView: View {
    let email: String?

    init(email: String? = nil) {
        self.email = email
    }

    var body: some View {
        VStack {
            Text("Forget Password")
            if let email = self.email {
                Text(email)
            }
        }
        
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView(email: "pedro@mail.com")
    }
}
