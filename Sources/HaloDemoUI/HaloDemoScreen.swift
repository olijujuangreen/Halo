//
//  HaloDemoScreen.swift
//  HaloDemoUI
//
//  Created by Olijujuan Green on 5/19/26.
//

import Halo
import SwiftUI

@MainActor
public struct HaloDemoScreen {
    struct ActionSection: Identifiable {
        let title: String
        let actions: [DemoAction]

        var id: String { title }
    }

    enum DemoAction: String, Identifiable {
        case autoDismiss
        case manual
        case typeErased
        case priorityReplacement
        case queueSequence
        case customLayout

        var id: String { rawValue }

        var title: String {
            switch self {
            case .autoDismiss: "Auto-dismiss halo"
            case .manual: "Manual halo"
            case .typeErased: "Type-erased item"
            case .priorityReplacement: "Priority replace"
            case .queueSequence: "Queue sequence"
            case .customLayout: "Custom layout"
            }
        }

        var subtitle: String {
            switch self {
            case .autoDismiss: "Presents generic SwiftUI content for two seconds."
            case .manual: "Stays visible until dismissed or replaced."
            case .typeErased: "Creates HaloItem with explicit AnyHaloContent."
            case .priorityReplacement: "Shows a low-priority item, then replaces it with critical."
            case .queueSequence: "Queues lower-priority items behind a critical item."
            case .customLayout: "Uses a taller island expansion with custom content padding."
            }
        }

        var symbol: String {
            switch self {
            case .autoDismiss: "timer"
            case .manual: "pin.fill"
            case .typeErased: "shippingbox.fill"
            case .priorityReplacement: "arrow.up.circle.fill"
            case .queueSequence: "list.number"
            case .customLayout: "rectangle.compress.vertical"
            }
        }
    }

    struct HaloSample: Identifiable {
        let id: AnyHashable
        let priority: HaloPriority
        let behavior: HaloBehavior
        let layout: HaloLayout
        let countsTaps: Bool
        let symbol: String
        let title: String
        let message: String
        let tint: Color

        init(
            id: AnyHashable,
            priority: HaloPriority = .normal,
            behavior: HaloBehavior = .default,
            layout: HaloLayout = .default,
            countsTaps: Bool = true,
            symbol: String,
            title: String,
            message: String,
            tint: Color
        ) {
            self.id = id
            self.priority = priority
            self.behavior = behavior
            self.layout = layout
            self.countsTaps = countsTaps
            self.symbol = symbol
            self.title = title
            self.message = message
            self.tint = tint
        }
    }

    @State var halo = HaloCenter()
    @State var tapCount = 0

    public init() {}

    var tapInteraction: HaloInteraction {
        HaloInteraction {
            tapCount += 1
        }
    }
}
