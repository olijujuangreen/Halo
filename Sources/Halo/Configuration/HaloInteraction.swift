//
//  HaloInteraction.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

/// User interaction attached to a presented halo item.
public struct HaloInteraction {
    public var onTap: (@MainActor () -> Void)?
    public var dragToDismiss: Bool

    public init(
        _ onTap: (@MainActor () -> Void)? = nil,
        dragToDismiss: Bool = true
    ) {
        self.onTap = onTap
        self.dragToDismiss = dragToDismiss
    }

    public static var `default`: HaloInteraction {
        HaloInteraction()
    }

    public static var passive: HaloInteraction {
        HaloInteraction(dragToDismiss: false)
    }
}
