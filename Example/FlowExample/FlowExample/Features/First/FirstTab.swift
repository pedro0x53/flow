import SwiftUI
import Flow

struct FirstTab: View {
    @State var presenter: FlowPresenter = .init()

    var body: some View {
        VStack(spacing: 8) {
            Text("FirstTab")
            Toggle("Present Sheet", isOn: $presenter.isPresented)
                .toggleStyle(.button)
        }
        .onAppear {
            presenter.setOnPresent {
                print("View Presented")
            }

            presenter.setOnDismiss {
                print("View Dismissed")
            }
        }
        .sheet(presenter) {
            Text("Presented View")
        }
    }
}

#Preview {
    FirstTab()
}
