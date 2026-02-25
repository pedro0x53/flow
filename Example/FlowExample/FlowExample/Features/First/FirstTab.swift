import SwiftUI
import Flow

struct FirstTab: FlowView {
    @State var presenter: FlowPresenter = .init()

    var body: some View {
        VStack(spacing: 8) {
            Text("FirstTab")
            Toggle("Present Sheet", isOn: $presenter.isPresented)
                .toggleStyle(.button)
        }
        .sheet(presenter) {
            Text("Presented View")
        }
    }
}

#Preview {
    FirstTab()
}
