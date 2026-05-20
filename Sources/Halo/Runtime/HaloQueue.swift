//
//  HaloQueue.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import Foundation

/// Internal priority queue that preserves insertion order for equal priorities.
struct HaloQueue {
    private var entries: [Entry] = []
    private var nextSequence = 0

    var count: Int {
        entries.count
    }

    mutating func enqueue(_ item: HaloItem) {
        nextSequence += 1
        entries.append(
            Entry(
                item: item,
                sequence: nextSequence
            )
        )
    }

    mutating func remove(id: AnyHashable) {
        entries.removeAll { entry in
            entry.item.id == id
        }
    }

    mutating func removeAll() {
        entries.removeAll()
        nextSequence = 0
    }

    mutating func popNext() -> HaloItem? {
        guard let nextIndex = entries.indices.max(by: isLowerPresentationPriority) else {
            return nil
        }

        return entries.remove(at: nextIndex).item
    }

    private func isLowerPresentationPriority(
        lhs: Array<Entry>.Index,
        rhs: Array<Entry>.Index
    ) -> Bool {
        let left = entries[lhs]
        let right = entries[rhs]

        if left.item.priority == right.item.priority {
            return left.sequence > right.sequence
        }

        return left.item.priority < right.item.priority
    }

    private struct Entry {
        let item: HaloItem
        let sequence: Int
    }
}
