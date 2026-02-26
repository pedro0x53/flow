import SwiftUI

public extension View {
    func sheet<Destination: View>(_ presenter: FlowPresenter,
                                  @ViewBuilder _ destination: @escaping () -> Destination) -> some View {
        @Bindable var presenter = presenter
        return self.sheet(isPresented: $presenter.isPresented) {
            destination()
                .environment(presenter)
        }
    }
}
