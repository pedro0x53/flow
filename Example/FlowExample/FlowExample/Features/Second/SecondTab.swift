import SwiftUI
import Flow

struct SecondTab: View {
    @State var coordinator: FlowStackCoordinator = .init()

    var body: some View {
        FlowStack(coordinator: coordinator) {
            VStack(spacing: 8) {
                // Imperatively push to the coordinator
                Button("Push A") {
                    coordinator.push(SecondTabRoutes.viewA)
                }

                // FlowRoute callAsFunction with title
                SecondTabRoutes.viewB("Title - Push B")

                // FlowRoute callAsFunction with Label (View)
                SecondTabRoutes.viewB {
                    Text("Label - Push B")
                }

                // FlowRoute callAsFunction with Label (View) and Destination (View)
                SecondTabRoutes.viewB {
                    Text("Label+Destination - Push B")
                } destination: {
                    ViewB()
                }
            }
            .navigationTitle("SecondTab")
            .navigationDestination(for: SecondTabRoutes.self) { route in
                // Used by:
                // 1. Imperative call to the coordinator,
                // 2. FlowRoute callAsFunction with title,
                // 3. FlowRoute callAsFunction with Label (View)
                switch route {
                case .viewA: ViewA()
                case .viewB: ViewB()
                }
            }
        }
    }
}

#Preview {
    SecondTab()
}
