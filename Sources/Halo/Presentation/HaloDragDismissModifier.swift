//
//  HaloDragDismissModifier.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import SwiftUI

struct HaloDragDismissModifier: ViewModifier {
    let isEnabled: Bool
    let center: HaloCenter
    let itemID: AnyHashable
    let threshold: CGFloat

    @State private var dragOffset: CGFloat = .zero

    @ViewBuilder
    func body(content: Content) -> some View {
        if isEnabled {
            content
                .offset(y: min(.zero, dragOffset))
                .gesture(dragGesture)
                .animation(.snappy(duration: 0.18), value: dragOffset)
        } else {
            content
        }
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 8)
            .onChanged { value in
                dragOffset = min(.zero, value.translation.height)
            }
            .onEnded { value in
                if value.translation.height <= -threshold {
                    center.dismiss(id: itemID)
                } else {
                    dragOffset = .zero
                }
            }
    }
}
