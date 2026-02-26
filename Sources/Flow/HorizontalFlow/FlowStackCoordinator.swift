import SwiftUI
import Observation

// MARK: The Coordinator that works with the SwiftUI NavigationStack
@Observable
public final class FlowStackCoordinator: FlowCoordinatorSchema {
    public var path: NavigationPath

    public required init(path: NavigationPath = .init()) {
        self.path = path
    }

    public func push<D: Hashable>(_ destination: D) {
        path.append(destination)
    }

    public func push<D: Hashable & Codable>(_ destination: D) {
        path.append(destination)
    }

    public func pop(_ count: Int = 1) {
        guard count <= path.count
        else {
            popToRoot()
            return
        }

        path.removeLast(count)
    }

    public func popToRoot() {
        path = .init()
    }

    // MARK: Codable conformance
    enum CodingKeys: String, CodingKey {
        case path
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let representation = try container.decode(NavigationPath.CodableRepresentation.self, forKey: .path)
        path = NavigationPath(representation)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard let representation = path.codable
        else {
            throw EncodingError.invalidValue(path, EncodingError.Context(
                codingPath: [CodingKeys.path],
                debugDescription: "Path contains non-Codable values"
            ))
        }

        try container.encode(representation, forKey: .path)
    }
}
