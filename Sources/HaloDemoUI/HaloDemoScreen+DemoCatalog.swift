//
//  HaloDemoScreen+DemoCatalog.swift
//  HaloDemoUI
//
//  Created by Olijujuan Green on 5/19/26.
//

import Halo
import SwiftUI

extension HaloDemoScreen {
    var actionSections: [ActionSection] {
        [
            ActionSection(
                title: "Basic Presentation",
                actions: [.autoDismiss, .manual, .typeErased]
            ),
            ActionSection(
                title: "Runtime Policy",
                actions: [.priorityReplacement, .queueSequence]
            ),
            ActionSection(
                title: "Layout",
                actions: [.customLayout]
            ),
        ]
    }
}

@MainActor
extension HaloDemoScreen.HaloSample {
    static let autoDismiss = Self(
        id: "auto-dismiss-demo",
        behavior: .autoDismiss(after: .seconds(2)),
        symbol: "checkmark.seal.fill",
        title: "Saved",
        message: "This halo will dismiss automatically.",
        tint: .green
    )

    static let manual = Self(
        id: "manual-demo",
        behavior: .manual,
        symbol: "pin.fill",
        title: "Pinned",
        message: "Use Dismiss All or drag upward.",
        tint: .orange
    )

    static let typeErased = Self(
        id: "erased-demo",
        priority: .high,
        behavior: .autoDismiss(after: .seconds(2)),
        symbol: "shippingbox.fill",
        title: "Type Erased",
        message: "This item was built with AnyHaloContent.",
        tint: .purple
    )

    static let replacementLow = Self(
        id: "replace-low",
        priority: .low,
        behavior: .manual,
        countsTaps: false,
        symbol: "arrow.down.circle.fill",
        title: "Low Priority",
        message: "A critical halo will replace this.",
        tint: .gray
    )

    static let replacementCritical = Self(
        id: "replace-critical",
        priority: .critical,
        behavior: .autoDismiss(after: .seconds(2)),
        symbol: "exclamationmark.triangle.fill",
        title: "Critical",
        message: "Higher priority replaces the current item.",
        tint: .red
    )

    static let customLayout = Self(
        id: "custom-layout-demo",
        behavior: .autoDismiss(after: .seconds(3)),
        layout: HaloLayout(
            height: 118,
            contentHorizontalPadding: 24
        ),
        symbol: "rectangle.compress.vertical",
        title: "Custom Layout",
        message: "HaloItem controls layout without changing the host.",
        tint: .cyan
    )

    static let queueSequence: [Self] = [
        Self(
            id: "queue-critical",
            priority: .critical,
            behavior: .autoDismiss(after: .seconds(1.4)),
            countsTaps: false,
            symbol: "1.circle.fill",
            title: "Critical First",
            message: "Lower-priority items wait in the queue.",
            tint: .red
        ),
        Self(
            id: "queue-high",
            priority: .high,
            behavior: .autoDismiss(after: .seconds(1.4)),
            countsTaps: false,
            symbol: "2.circle.fill",
            title: "High Second",
            message: "The highest queued priority presents next.",
            tint: .blue
        ),
        Self(
            id: "queue-normal-first",
            priority: .normal,
            behavior: .autoDismiss(after: .seconds(1.4)),
            countsTaps: false,
            symbol: "3.circle.fill",
            title: "Normal Third",
            message: "This normal item was queued before the next one.",
            tint: .green
        ),
        Self(
            id: "queue-normal-second",
            priority: .normal,
            behavior: .autoDismiss(after: .seconds(1.4)),
            countsTaps: false,
            symbol: "4.circle.fill",
            title: "Normal Fourth",
            message: "Same-priority items preserve insertion order.",
            tint: .mint
        ),
    ]
}
