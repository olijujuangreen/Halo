//
//  HaloDemoScreen+PresentationActions.swift
//  HaloDemoUI
//
//  Created by Olijujuan Green on 5/19/26.
//

import Halo
import SwiftUI

extension HaloDemoScreen {
    func perform(_ action: DemoAction) {
        switch action {
        case .autoDismiss: present(.autoDismiss)
        case .manual: present(.manual)
        case .typeErased: presentTypeErasedHalo()
        case .priorityReplacement: presentPriorityReplacement()
        case .queueSequence: presentQueueSequence()
        case .customLayout: present(.customLayout)
        }
    }

    func present(_ sample: HaloSample) {
        halo.present(
            id: sample.id,
            priority: sample.priority,
            behavior: sample.behavior,
            layout: layout(for: sample),
            interaction: interaction(for: sample)
        ) {
            PresentedHaloContent(sample: sample)
        }
    }

    func presentTypeErasedHalo() {
        let sample = HaloSample.typeErased
        let item = HaloItem(
            id: sample.id,
            priority: sample.priority,
            behavior: sample.behavior,
            layout: layout(for: sample),
            interaction: interaction(for: sample),
            content: AnyHaloContent(
                AnyView(PresentedHaloContent(sample: sample))
            )
        )

        halo.present(item)
    }

    func presentPriorityReplacement() {
        present(.replacementLow)

        // Give the low-priority presentation time to appear before Halo's
        // replacement policy is demonstrated by the critical item.
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(450))
            present(.replacementCritical)
        }
    }

    func presentQueueSequence() {
        HaloSample.queueSequence.forEach(present)
    }

    func interaction(for sample: HaloSample) -> HaloInteraction {
        sample.countsTaps ? tapInteraction : .default
    }

    private func layout(for sample: HaloSample) -> HaloLayout {
        sample.layout.avoidingCameraCutout(
            when: sample.title.count >= Layout.cameraCutoutTitleCharacterCount
        )
    }
}

private extension HaloDemoScreen {
    enum Layout {
        static let cameraCutoutTitleCharacterCount = 11
    }
}
