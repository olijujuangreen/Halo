//
//  HaloHostConfiguration.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import SwiftUI

/// Host-level styling and gesture thresholds shared by all presented items.
public struct HaloHostConfiguration {
    public var surfaceFill: Color
    public var animation: Animation
    public var dragDismissThreshold: CGFloat

    public init(
        surfaceFill: Color = .black,
        animation: Animation = .bouncy(duration: 0.3),
        dragDismissThreshold: CGFloat = 36
    ) {
        self.surfaceFill = surfaceFill
        self.animation = animation
        self.dragDismissThreshold = dragDismissThreshold
    }

    public static var `default`: HaloHostConfiguration {
        HaloHostConfiguration()
    }
}
