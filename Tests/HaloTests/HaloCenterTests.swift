//
//  HaloCenterTests.swift
//  HaloTests
//
//  Created by Olijujuan Green on 5/19/26.
//

import SwiftUI
import Testing
@testable import Halo

@Test("presenting with no current item shows immediately")
@MainActor
func presentingWithNoCurrentItemShowsImmediately() {
    let center = HaloCenter()

    center.present(testItem(id: "first"))

    #expect(center.current?.id == AnyHashable("first"))
    #expect(center.queuedItemCount == 0)
}

@Test("equal priority replaces current")
@MainActor
func equalPriorityReplacesCurrent() {
    let center = HaloCenter()

    center.present(testItem(id: "first", priority: .normal))
    center.present(testItem(id: "second", priority: .normal))

    #expect(center.current?.id == AnyHashable("second"))
    #expect(center.queuedItemCount == 0)
}

@Test("higher priority replaces current")
@MainActor
func higherPriorityReplacesCurrent() {
    let center = HaloCenter()

    center.present(testItem(id: "first", priority: .normal))
    center.present(testItem(id: "second", priority: .critical))

    #expect(center.current?.id == AnyHashable("second"))
    #expect(center.queuedItemCount == 0)
}

@Test("lower priority queues behind current")
@MainActor
func lowerPriorityQueuesBehindCurrent() {
    let center = HaloCenter()

    center.present(testItem(id: "current", priority: .high))
    center.present(testItem(id: "queued", priority: .low))

    #expect(center.current?.id == AnyHashable("current"))
    #expect(center.queuedItemCount == 1)
}

@Test("queued items present after dismissal by priority and insertion order")
@MainActor
func queuedItemsPresentAfterDismissalByPriorityAndInsertionOrder() {
    let center = HaloCenter()

    center.present(testItem(id: "current", priority: .critical))
    center.present(testItem(id: "low", priority: .low))
    center.present(testItem(id: "high-first", priority: .high))
    center.present(testItem(id: "high-second", priority: .high))

    center.dismissCurrent()

    #expect(center.current?.id == AnyHashable("high-first"))
    #expect(center.queuedItemCount == 2)

    center.dismissCurrent()

    #expect(center.current?.id == AnyHashable("high-second"))
    #expect(center.queuedItemCount == 1)

    center.dismissCurrent()

    #expect(center.current?.id == AnyHashable("low"))
    #expect(center.queuedItemCount == 0)
}

@Test("auto-dismiss clears current after duration")
@MainActor
func autoDismissClearsCurrentAfterDuration() async throws {
    let center = HaloCenter()

    center.present(
        testItem(
            id: "auto",
            behavior: .autoDismiss(after: .milliseconds(20))
        )
    )

    #expect(center.current?.id == AnyHashable("auto"))

    try await Task.sleep(for: .milliseconds(60))

    #expect(center.current == nil)
}

@Test("manual dismissal cancels pending auto-dismiss task")
@MainActor
func manualDismissalCancelsPendingAutoDismissTask() async throws {
    let center = HaloCenter()

    center.present(
        testItem(
            id: "reused",
            behavior: .autoDismiss(after: .milliseconds(40))
        )
    )
    center.dismissCurrent()
    center.present(testItem(id: "reused", behavior: .manual))

    try await Task.sleep(for: .milliseconds(80))

    #expect(center.current?.id == AnyHashable("reused"))
}

@Test("dismissAll clears current and queue")
@MainActor
func dismissAllClearsCurrentAndQueue() {
    let center = HaloCenter()

    center.present(testItem(id: "current", priority: .critical))
    center.present(testItem(id: "queued-one", priority: .normal))
    center.present(testItem(id: "queued-two", priority: .low))

    center.dismissAll()

    #expect(center.current == nil)
    #expect(center.queuedItemCount == 0)
}

@Test("dismissing a queued item removes it without disturbing current")
@MainActor
func dismissingQueuedItemRemovesItWithoutDisturbingCurrent() {
    let center = HaloCenter()

    center.present(testItem(id: "current", priority: .critical))
    center.present(testItem(id: "queued-high", priority: .high))
    center.present(testItem(id: "queued-low", priority: .low))

    center.dismiss(id: AnyHashable("queued-high"))
    center.dismissCurrent()

    #expect(center.current?.id == AnyHashable("queued-low"))
    #expect(center.queuedItemCount == 0)
}

@Test("camera cutout avoidance expands layout only when requested")
func cameraCutoutAvoidanceExpandsLayoutOnlyWhenRequested() {
    let defaultLayout = HaloLayout()
    let customTallLayout = HaloLayout(height: 118)

    #expect(defaultLayout.height == 90)
    #expect(defaultLayout.avoidingCameraCutout(when: false).height == 90)
    #expect(defaultLayout.avoidingCameraCutout().height == 104)
    #expect(HaloLayout.cameraCutoutAvoiding.height == 104)
    #expect(customTallLayout.avoidingCameraCutout().height == 118)
}

@MainActor
private func testItem(
    id: String,
    priority: HaloPriority = .normal,
    behavior: HaloBehavior = .manual
) -> HaloItem {
    HaloItem(
        id: AnyHashable(id),
        priority: priority,
        behavior: behavior
    ) {
        Text(id)
    }
}
