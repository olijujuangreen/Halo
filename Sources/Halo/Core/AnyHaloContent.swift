//
//  AnyHaloContent.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import SwiftUI

/// Type-erased SwiftUI content stored by `HaloItem`.
public struct AnyHaloContent {
    private let makeView: @MainActor () -> AnyView

    @MainActor
    public init(_ view: AnyView) {
        self.makeView = { view }
    }

    @MainActor
    public init<Content: View>(
        @ViewBuilder _ content: @escaping @MainActor () -> Content
    ) {
        self.makeView = {
            AnyView(content())
        }
    }

    @MainActor
    func resolve() -> AnyView {
        makeView()
    }
}
