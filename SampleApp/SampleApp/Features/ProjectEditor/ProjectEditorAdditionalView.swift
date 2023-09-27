//
//  ProjectEditorAdditionalView.swift
//  Flow
//
//  Created by Pedro Sousa on 22/08/23.
//

import SwiftUI

struct ProjectEditorAdditionalView: View {
    @ObservedObject var router: ProjectCoordinator

    var body: some View {
        Text("Second Step")
    }
}

struct ProjectEditorAdditionalView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectEditorAdditionalView(router: .init())
    }
}
