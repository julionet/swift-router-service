import UIKit

public protocol Feature {
    func build(fromRoute route: Route?) -> UIViewController
    func resolve(withStore store: StoreInterface)
    func isEnabled() -> Bool
    func fallback(forRoute route: Route?) -> Feature.Type?
    init()
}

public extension Feature {
    func resolve(withStore store: StoreInterface) {
        let mirror = Mirror(reflecting: self)
        for children in mirror.children {
            if let resolvable = children.value as? Resolvable {
                resolvable.resolve(withStore: store)
            }
        }
    }

    func isEnabled() -> Bool { return true }

    func fallback(forRoute route: Route?) -> Feature.Type? { return nil }
}
