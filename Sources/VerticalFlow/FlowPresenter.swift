import Observation

@Observable
public final class FlowPresenter: Codable {
    public var isPresented: Bool = false
    public private(set) var onPresent: (() -> Void)? = nil
    public private(set) var onDismiss: (() -> Void)? = nil

    public init(isPresented: Bool = false,
                onPresent: (() -> Void)? = nil,
                onDismiss: (() -> Void)? = nil) {
        self.isPresented = isPresented
        self.onPresent = onPresent
        self.onDismiss = onDismiss
    }

    public func present() {
        self.isPresented = true
        onPresent?()
    }

    public func dismiss() {
        self.isPresented = false
        onDismiss?()
    }

    public func setOnPresent(_ onPresent: @escaping () -> Void) {
        self.onPresent = onPresent
    }

    public func setOnDismiss(_ onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
    }

    // MARK: Codable conformance
    enum CodingKeys: String, CodingKey {
        case isPresented
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isPresented = try container.decode(Bool.self, forKey: .isPresented)
        onPresent = nil
        onDismiss = nil
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(isPresented, forKey: .isPresented)
    }
}
