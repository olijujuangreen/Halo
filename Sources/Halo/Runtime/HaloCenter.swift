//
//  HaloCenter.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import Foundation
import Observation
import SwiftUI

/// Main-actor presentation controller for a root-mounted Halo host.
@MainActor
@Observable
public final class HaloCenter {
    public private(set) var current: HaloItem?

    @ObservationIgnored
    private var queue = HaloQueue()

    @ObservationIgnored
    private var dismissalTask: Task<Void, Never>?

    var queuedItemCount: Int {
        queue.count
    }

    public init() {}

    public func present(_ item: HaloItem) {
        guard let current else {
            presentNow(item)
            return
        }

        if shouldReplaceCurrentItem(with: item, current: current) {
            presentNow(item)
        } else {
            queue.enqueue(item)
        }
    }

    public func present<Content: View>(
        id: AnyHashable = AnyHashable(UUID()),
        priority: HaloPriority = .normal,
        behavior: HaloBehavior = .default,
        layout: HaloLayout = .default,
        interaction: HaloInteraction = .default,
        @ViewBuilder content: @escaping @MainActor () -> Content
    ) {
        present(
            HaloItem(
                id: id,
                priority: priority,
                behavior: behavior,
                layout: layout,
                interaction: interaction,
                content: content
            )
        )
    }

    public func dismissCurrent() {
        dismissalTask?.cancel()
        dismissalTask = nil
        current = nil
        presentNextQueuedItem()
    }

    public func dismiss(id: AnyHashable) {
        if current?.id == id {
            dismissCurrent()
        } else {
            queue.remove(id: id)
        }
    }

    public func dismissAll() {
        dismissalTask?.cancel()
        dismissalTask = nil
        current = nil
        queue.removeAll()
    }

    private func shouldReplaceCurrentItem(
        with item: HaloItem,
        current: HaloItem
    ) -> Bool {
        item.priority >= current.priority
    }

    private func presentNow(_ item: HaloItem) {
        dismissalTask?.cancel()
        dismissalTask = nil
        current = item
        scheduleDismissalIfNeeded(for: item)
    }

    private func scheduleDismissalIfNeeded(for item: HaloItem) {
        guard case .autoDismiss(let duration) = item.behavior else { return }

        dismissalTask = Task { @MainActor [weak self, itemID = item.id] in
            try? await Task.sleep(for: duration)
            guard !Task.isCancelled else { return }
            self?.dismiss(id: itemID)
        }
    }

    private func presentNextQueuedItem() {
        guard let nextItem = queue.popNext() else { return }
        presentNow(nextItem)
    }
}
