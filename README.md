# Halo

Halo is a SwiftUI-only presentation host for top-of-screen Dynamic Island interactions. It gives an app one small controller for presenting type-erased content in a black island-extension surface, with priority replacement, queueing, tap actions, auto-dismiss, manual dismissal, and drag-to-dismiss.

Halo is intentionally generic. It does not know about success toasts, errors, downloads, playback, or any app-specific event names. Those semantics belong in the consuming app. The package-owned shell is always meant to read as an expansion of the Dynamic Island, not as a detached surface.

## Requirements

- iOS 26+
- Swift 6

## Installation

Add Halo as a Swift Package dependency:

```swift
.package(url: "https://github.com/your-org/Halo.git", from: "0.1.0")
```

Then add the product to your app target:

```swift
.product(name: "Halo", package: "Halo")
```

## Demo

The package includes a SwiftUI demo target named `HaloDemo`. Open the package in Xcode, select the `HaloDemo` scheme, and run it on an iOS 26 simulator.

The demo app entry point lives in `Sources/HaloDemo`, and the previewable SwiftUI screen lives in `Sources/HaloDemoUI`. The demo shows the expected integration pattern:

- create `@State private var halo = HaloCenter()`
- mount `.haloHost(halo)` once at the screen root
- present builder-based SwiftUI content
- present a strictly type-erased `HaloItem`
- exercise auto-dismiss, manual dismiss, priority replacement, queueing, tap handling, drag-to-dismiss, and custom layout

You can also verify the demo target from the command line:

```sh
xcodebuild build -scheme HaloDemo -destination 'platform=iOS Simulator,name=iPhone Air,OS=26.5'
```

## Usage

Create and mount a single `HaloCenter` near the root of your SwiftUI app:

```swift
import Halo
import SwiftUI

struct RootView: View {
    @State private var halo = HaloCenter()

    var body: some View {
        ContentView()
            .haloHost(halo)
    }
}
```

Present any SwiftUI content:

```swift
halo.present(
    priority: .normal,
    behavior: .autoDismiss(after: .seconds(2)),
    interaction: HaloInteraction {
        print("Tapped")
    }
) {
    HStack(spacing: 10) {
        Image(systemName: "checkmark.seal.fill")
            .foregroundStyle(.green)

        VStack(alignment: .leading, spacing: 4) {
            Text("Saved")
                .font(.callout.weight(.semibold))
            Text("Your changes were saved.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .foregroundStyle(.white)

        Spacer()
    }
}
```

Use cutout-avoiding layout only for content that needs the extra clearance:

```swift
halo.present(layout: .cameraCutoutAvoiding) {
    Text("Longer title that would otherwise run under the camera")
        .foregroundStyle(.white)
}
```

You can also construct strictly type-erased items:

```swift
let item = HaloItem(
    id: "download-started",
    priority: .high,
    behavior: .manual,
    content: AnyHaloContent(
        AnyView(Text("Download started").foregroundStyle(.white))
    )
)

halo.present(item)
```
# Halo
