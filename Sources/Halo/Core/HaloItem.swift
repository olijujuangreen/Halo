//
//  HaloItem.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import Foundation
import SwiftUI

/// A fully type-erased presentation request managed by `HaloCenter`.
public struct HaloItem: Identifiable {
    public let id: AnyHashable
    public let priority: HaloPriority
    public let behavior: HaloBehavior
    public let layout: HaloLayout
    public let interaction: HaloInteraction
    public let content: AnyHaloContent

    public init(
        id: AnyHashable = AnyHashable(UUID()),
        priority: HaloPriority = .normal,
        behavior: HaloBehavior = .default,
        layout: HaloLayout = .default,
        interaction: HaloInteraction = .default,
        content: AnyHaloContent
    ) {
        self.id = id
        self.priority = priority
        self.behavior = behavior
        self.layout = layout
        self.interaction = interaction
        self.content = content
    }

    @MainActor
    public init<Content: View>(
        id: AnyHashable = AnyHashable(UUID()),
        priority: HaloPriority = .normal,
        behavior: HaloBehavior = .default,
        layout: HaloLayout = .default,
        interaction: HaloInteraction = .default,
        @ViewBuilder content: @escaping @MainActor () -> Content
    ) {
        self.init(
            id: id,
            priority: priority,
            behavior: behavior,
            layout: layout,
            interaction: interaction,
            content: AnyHaloContent(content)
        )
    }
}
