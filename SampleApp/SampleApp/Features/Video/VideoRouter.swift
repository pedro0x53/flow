//
//  VideoRouter.swift
//  Flow
//
//  Created by Pedro Sousa on 01/09/23.
//

import SwiftUI
import Flow

class VideoRouter: Router {
    weak var parent: DashboardCoordinator?

    required init(parent: DashboardCoordinator? = nil) {
        self.parent = parent
    }

    @ViewBuilder func build() -> some View {
        VideoView(router: self)
    }
}

extension VideoRouter {
    static func == (lhs: VideoRouter, rhs: VideoRouter) -> Bool {
        lhs.id == rhs.id
    }
}
