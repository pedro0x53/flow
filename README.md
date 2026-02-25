# Flow

A SwiftUI navigation library for type-safe stack navigation, sheet presentation, and tab-based layouts.

## Requirements

- iOS 18.0+
- Swift 6.2+

## Installation

### Swift Package Manager

Add Flow to your project via Xcode (File → Add Package Dependencies) or by adding it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/Flow.git", from: "2.0.0")
]
```

## Overview

Flow is organized into three layers:

| Layer | Purpose |
|-------|---------|
| **Horizontal Flow** | Stack navigation (push/pop) with `NavigationStack` |
| **Vertical Flow** | Sheet presentation |
| **Context Flow** | Tab-based navigation |

---

## Horizontal Flow

Stack navigation with `FlowStack`, `FlowStackCoordinator`, and `FlowRoute`.

### Define Routes

Conform to `FlowRoute` (or `FlowView` if the route is also a `View`):

```swift
import Flow
import SwiftUI

// Option 1: FlowView — route and view are the same
struct ProfileView: FlowView {
    var body: some View {
        Text("Profile")
    }
}

struct SettingsView: FlowView {
    var body: some View {
        Text("Settings")
    }
}

// Option 2: Enum routes with associated values (for deep linking)
enum AppRoute: FlowRoute {
    case profile(userId: String)
    case settings

    @ViewBuilder
    var destination: some View {
        switch self {
        case .profile(let userId):
            ProfileDetailView(userId: userId)
        case .settings:
            SettingsView()
        }
    }
}
```

### Set Up the Stack

```swift
struct ContentView: View {
    @State var coordinator = FlowStackCoordinator()

    var body: some View {
        FlowStack(coordinator: coordinator) {
            VStack(spacing: 16) {
                Text("Home")
                    .destination(ProfileView.self)
                    .destination(SettingsView.self)

                Button("Go to Profile") {
                    coordinator.push(ProfileView())
                }

                Button("Go to Settings") {
                    coordinator.push(SettingsView())
                }
            }
        }
    }
}
```

### Push, Pop, Pop to Root

```swift
// Push
coordinator.push(ProfileView())

// Pop one screen
coordinator.pop()

// Pop multiple screens
coordinator.pop(2)

// Pop to root
coordinator.popToRoot()
```

---

## Vertical Flow

Sheet presentation with `FlowPresenter` and the `sheet(_:_:)` modifier.

### Present a Sheet

```swift
import Flow
import SwiftUI

struct ContentView: View {
    @State var presenter = FlowPresenter()

    var body: some View {
        Button("Present Sheet") {
            presenter.present()
        }
        .sheet(presenter) {
            Text("Sheet Content")
        }
    }
}
```

### Dismiss and Lifecycle Callbacks

```swift
struct DetailView: View {
    @Environment(FlowPresenter.self) var presenter

    var body: some View {
        VStack {
            Text("Detail")
            Button("Dismiss") {
                presenter.dismiss()
            }
        }
    }
}

// With callbacks
let presenter = FlowPresenter()
presenter.setOnPresent { print("Sheet presented") }
presenter.setOnDismiss { print("Sheet dismissed") }
```

---

## Context Flow

Tab navigation with `FlowTabView`, `FlowTabCoordinator`, and `FlowTab`.

### Define Tabs

```swift
import Flow
import SwiftUI

enum MyTabs: String, CaseIterable, FlowTabs {
    case home
    case search
    case profile

    static var tabs: [MyTabs] { MyTabs.allCases }

    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .profile: return "Profile"
        }
    }

    var image: FlowTabImage {
        switch self {
        case .home: return .system("house")
        case .search: return .system("magnifyingglass")
        case .profile: return .system("person")
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .home: HomeTab()
        case .search: SearchTab()
        case .profile: ProfileTab()
        }
    }
}
```

### Set Up the Tab View

```swift
@main
struct MyApp: App {
    let tabCoordinator = FlowTabCoordinator<MyTabs>(tab: .home)

    var body: some Scene {
        WindowGroup {
            FlowTabView(tabCoordinator: tabCoordinator)
        }
    }
}
```

### Switch Tabs Programmatically

```swift
struct HomeTab: View {
    @Environment(FlowTabCoordinator<MyTabs>.self) var tabCoordinator

    var body: some View {
        Button("Go to Profile") {
            tabCoordinator.select(tab: .profile)
        }
    }
}
```

---

## Combining Flows

Tabs with nested stack and sheet flows:

```swift
struct HomeTab: FlowView {
    @State var coordinator = FlowStackCoordinator()
    @State var sheetPresenter = FlowPresenter()

    var body: some View {
        FlowStack(coordinator: coordinator) {
            VStack {
                Text("Home")
                    .destination(DetailView.self)

                Button("Push Detail") {
                    coordinator.push(DetailView())
                }

                Button("Present Sheet") {
                    sheetPresenter.present()
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

## Codable & Deep Linking

Flow routes and coordinators conform to `Codable` to support:

- Path persistence and restoration
- Deep linking via URL parsing

### FlowRoute

`FlowRoute` requires `Codable`. Use enums or structs whose stored properties are `Codable`:

```swift
enum AppRoute: FlowRoute {
    case home
    case profile(userId: String)
    case settings
    // ...
}
```

### Path Persistence

`FlowStackCoordinator` uses `NavigationPath.CodableRepresentation` for encoding and decoding the stack, so paths can be saved and restored.

---

## License

This project is licensed under the [MIT License](LICENSE).
