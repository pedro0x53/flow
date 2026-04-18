import SwiftUI

public struct FlowRouteContent<R: FlowRoute, Content: View> {
    let route: R
    let content: () -> Content
}
