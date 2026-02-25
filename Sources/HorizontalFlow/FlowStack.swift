import SwiftUI

public struct FlowStack<Root: View>: View {
    @Bindable var coordinator: FlowStackCoordinator
    var root: () -> Root

    public init(coordinator: FlowStackCoordinator,
                @ViewBuilder root: @escaping () -> Root) {
        self.coordinator = coordinator
        self.root = root
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            root()
                .environment(coordinator)
        }
    }
}
