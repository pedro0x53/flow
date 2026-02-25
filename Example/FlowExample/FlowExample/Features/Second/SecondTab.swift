import SwiftUI
import Flow

struct SecondTab: FlowView {
    @State var coordinator: FlowStackCoordinator = .init()

    var body: some View {
        FlowStack(coordinator: coordinator) {
            VStack(spacing: 8) {
                Text("SecondTab")
                    .destination(ViewA.self)
                    .destination(ViewB.self)

                Button("Push A") {
                    coordinator.push(ViewA())
                }

                Button("Push B") {
                    coordinator.push(ViewB())
                }
            }
        }
    }
}

#Preview {
    SecondTab()
}
