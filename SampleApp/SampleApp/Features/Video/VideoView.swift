//
//  VideoView.swift
//  Flow
//
//  Created by Pedro Sousa on 29/08/23.
//

import SwiftUI

struct VideoView: View {
    var router: VideoRouter

    var body: some View {
        VStack {
            Button("Push to Channel") {
                router.push(VideoRouter.Coordinates.channel)
            }

            Button("Push to Report") {
                router.push(VideoRouter.Coordinates.report)
            }

            Button("Back to Dashboard") {
                router.popToRoot()
            }
        }
        .navigationDestination(for: VideoRouter.Coordinates.self) { coordinate in
            switch coordinate {
            case .channel:
                Text("Channel")
            case .report:
                VStack {
                    Text("Report")
                    Button("Back to Video") {
                        router.pop()
                    }
                }
            }
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    @ObservedObject static var coordinator: DashboardCoordinator = .init(appCoordinator: .init())
    static var previews: some View {
        NavigationStack(path: VideoView_Previews.$coordinator.path) {
            VideoView(router: .init(parent: VideoView_Previews.coordinator))
        }
    }
}
