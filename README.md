# Flow

A SwiftUI navigation library for type-safe stack navigation, sheet presentation, and tab-based layouts — built on top of `NavigationStack`, `TabView`, and the `sheet` / `fullScreenCover` modifiers, but with observable coordinators so you can drive navigation from anywhere in your view hierarchy.

## Requirements

- iOS 18.0+
- Swift 6.2+

## Installation

### Swift Package Manager

Add Flow to your project via Xcode (File → Add Package Dependencies) or by adding it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/pedro0x53/flow", from: "2.0.0")
]
```

## Overview

Flow is organized into three layers, each solving a different navigation problem:

| Layer | Purpose |
|-------|---------|
| **Horizontal Flow** | Stack navigation (push/pop) backed by `NavigationStack` |
| **Vertical Flow** | Sheet and full-screen cover presentation |
| **Context Flow** | Tab-based navigation backed by `TabView` |

The three layers are independent and composable — you can mix and match them freely. There's a working `Example/` app in the repo that shows most of the patterns below in practice.

---

## Horizontal Flow

Stack navigation is built around three pieces: `FlowStack` (the container view), `FlowStackCoordinator` (an `@Observable` object that owns the `NavigationPath`), and `FlowRoute` (a protocol your routes conform to).

### Define Routes

A `FlowRoute` is just a `Hashable & Codable` value. The usual way to model one is an enum — each case represents a screen, and you use `.navigationDestination(for:)` to resolve cases into views.

```swift
import Flow
import SwiftUI

enum SecondTabRoutes: FlowRoute {
    case viewA
    case viewB
}
```

### Set Up the Stack

Create a `FlowStackCoordinator`, hand it to `FlowStack`, and attach a `.navigationDestination(for:)` for your route type. The coordinator is available in the environment, so child views can read it with `@Environment(FlowStackCoordinator.self)`.

```swift
struct SecondTab: View {
    @State var coordinator: FlowStackCoordinator = .init()

    var body: some View {
        FlowStack(coordinator: coordinator) {
            VStack {
                Button("Push A") {
                    coordinator.push(SecondTabRoutes.viewA)
                }
            }
            .navigationTitle("SecondTab")
            .navigationDestination(for: SecondTabRoutes.self) { route in
                switch route {
                case .viewA: ViewA()
                case .viewB: ViewB()
                }
            }
        }
    }
}
```

### Push, Pop, Pop to Root

```swift
// Push
coordinator.push(SecondTabRoutes.viewA)

// Pop one screen
coordinator.pop()

// Pop multiple screens
coordinator.pop(2)

// Pop to root (also called automatically if `pop(count:)` is asked to pop more screens than exist)
coordinator.popToRoot()
```

### FlowRoute as a NavigationLink

Because `FlowRoute` implements `callAsFunction`, every route value doubles as a link builder. This removes the boilerplate of wrapping every `NavigationLink` by hand — the route carries both the identity and the link sugar.

```swift
// With a title
SecondTabRoutes.viewB("Push B")

// With a custom label view
SecondTabRoutes.viewB {
    Text("Push B")
        .foregroundStyle(.blue)
}

// With a custom label AND a custom destination
// (bypasses navigationDestination — handy for ad-hoc links)
SecondTabRoutes.viewB {
    Text("Push B")
} destination: {
    ViewB()
}
```

The first two variants route through `.navigationDestination(for:)`, so they share the same resolution logic as the imperative `coordinator.push(...)`. The third variant provides its destination inline, so it doesn't need the route to be registered.

---

## Vertical Flow

Sheet and full-screen presentation use `FlowPresenter` — an observable object that tracks `isPresented` — together with the `.sheet(_:_:)` and `.fullScreenCover(_:_:)` modifiers Flow adds to `View`.

### Present a Sheet

Drive presentation either by calling `present()` on the presenter or by binding `isPresented` directly (e.g. to a Toggle).

```swift
import Flow
import SwiftUI

struct FirstTab: View {
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
```

For a full-screen cover, swap `.sheet(presenter)` for `.fullScreenCover(presenter)` — same API.

### Dismiss from the Presented View

The presenter is injected into the presented view's environment, so the child view can dismiss itself without the parent wiring anything up:

```swift
struct DetailView: View {
    @Environment(FlowPresenter.self) var presenter

    var body: some View {
        Button("Dismiss") {
            presenter.dismiss()
        }
    }
}
```

### Lifecycle Callbacks

`FlowPresenter` exposes `onPresent` and `onDismiss` hooks. Set them at init time or attach them later (e.g. in `.onAppear`):

```swift
.onAppear {
    presenter.setOnPresent { print("View Presented") }
    presenter.setOnDismiss { print("View Dismissed") }
}
```

These hooks are called whenever the `presenter.isPresented` changes.

---

## Context Flow

Tab navigation uses `FlowTabView` (the container), `FlowTabCoordinator` (the selection state), and a `FlowTabs` enum that describes your tabs.

### Define Tabs

Conform an enum to `FlowTabs` (which is `FlowTab + FlowTabOptions`). The only required property is `label: FlowTabLabel`, which pairs a title with an icon. Marking the enum `CaseIterable` is enough to satisfy `FlowTabOptions` — you get the `tabs` array for free.

```swift
import Flow

enum MyTabs: FlowTabs, CaseIterable {
    case first
    case second

    var label: FlowTabLabel {
        switch self {
        case .first:  .init("First", .system("heart"))
        case .second: .init("Second", .system("star"))
        }
    }
}
```

`FlowTabLabel` takes a title and a `FlowTabImage`, which is either `.system("SF Symbol name")` or `.named("Asset name")`.

### Set Up the Tab View

Instantiate a `FlowTabCoordinator` with the initial tab, pass it to `FlowTabView`, and use each case's `callAsFunction` to build its content.

```swift
@main
struct FlowExampleApp: App {
    @State var tabCoordinator = FlowTabCoordinator<MyTabs>(tab: .first)

    var body: some Scene {
        WindowGroup {
            FlowTabView(tabCoordinator: tabCoordinator) {
                MyTabs.first {
                    FirstTab()
                }

                MyTabs.second {
                    SecondTab()
                }
            }
        }
    }
}
```

### Switch Tabs Programmatically

Read the coordinator from the environment and call `select(tab:)`:

```swift
struct HomeTab: View {
    @Environment(FlowTabCoordinator<MyTabs>.self) var tabCoordinator

    var body: some View {
        Button("Go to Second") {
            tabCoordinator.select(tab: .second)
        }
    }
}
```

---

## Combining Flows

Each tab can own its own stack and its own presenter — they're fully independent because each layer manages its own state. A typical pattern looks like this:

```swift
struct SecondTab: View {
    @State var coordinator: FlowStackCoordinator = .init()
    @State var sheetPresenter: FlowPresenter = .init()

    var body: some View {
        FlowStack(coordinator: coordinator) {
            VStack {
                Button("Push A") {
                    coordinator.push(SecondTabRoutes.viewA)
                }

                Button("Present Sheet") {
                    sheetPresenter.present()
                }
            }
            .navigationDestination(for: SecondTabRoutes.self) { route in
                switch route {
                case .viewA: ViewA()
                case .viewB: ViewB()
                }
            }
        }
        .sheet(sheetPresenter) {
            Text("Sheet Content")
        }
    }
}
```

---

## Codable & Path Persistence

All Flow coordinators conform to `Codable` so you can persist navigation state (e.g. for scene restoration or deep linking). There's one thing to be careful about: `NavigationPath` can only encode values that are themselves `Codable`.

`FlowRoute` already requires `Hashable & Codable`, so any route type you define works out of the box. But `FlowStackCoordinator.push` also has an overload that accepts any `Hashable` value — if you push something non-Codable through it, encoding the coordinator will throw `EncodingError.invalidValue` with the message *"Path contains non-Codable values"*.

A few practical notes:

- **`FlowStackCoordinator`\*, `FlowTabCoordinator`, and `FlowPresenter` are Codable**, so they can be persisted and restored.
- **Prefer `FlowRoute` enums for persistable stacks.** They give you compile-time assurance that the path is encodable.
- **`FlowStackCoordinator`** will only be encoded if all of the components of its `path` are `Codable`.
- **`FlowPresenter` is Codable,** but only `isPresented` is encoded — `onPresent` and `onDismiss` closures are not restored on decode, so re-attach them after restoration if you need them.

---

## License

This project is licensed under the [MIT License](LICENSE).
