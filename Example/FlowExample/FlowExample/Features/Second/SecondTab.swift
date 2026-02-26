import SwiftUI
import Flow

struct SecondTab: View {
    @State var coordinator: FlowStackCoordinator = .init()

    var body: some View {
        FlowStack(coordinator: coordinator) {
            VStack(spacing: 8) {
                Text("SecondTab")
                    .destination(SecondTabRoutes.self)

                Button("Push A") {
                    coordinator.push(SecondTabRoutes.viewA)
                }

                Button("Push B") {
                    coordinator.push(SecondTabRoutes.viewB)
                }
            }
        }
    }
}

#Preview {
    SecondTab()
}
