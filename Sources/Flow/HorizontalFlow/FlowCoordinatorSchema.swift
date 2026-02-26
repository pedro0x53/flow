// MARK: The Schema that every Coordinator must follow
public protocol FlowCoordinatorSchema: AnyObject, Codable {
    associatedtype P: FlowPath
    var path: P { get set }

    init(path: P)

    func push<D: Hashable>(_ destination: D)
    func push<D: Hashable & Codable>(_ destination: D)
    func pop(_ count: Int)
    func popToRoot()
}
