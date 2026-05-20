//
//  HaloHostModifier.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import SwiftUI

struct HaloHostModifier: ViewModifier {
    let center: HaloCenter
    let configuration: HaloHostConfiguration

    func body(content: Content) -> some View {
        content.overlay(alignment: .top) {
            GeometryReader { proxy in
                ZStack(alignment: .top) {
                    if let item = center.current {
                        HaloPresentedItemView(
                            center: center,
                            item: item,
                            configuration: configuration
                        )
                        .padding(.horizontal, item.layout.horizontalInset)
                        .offset(y: topOffset(for: item, in: proxy))
                        .transition(.scale(scale: 0.34, anchor: .top).combined(with: .opacity))
                        .zIndex(1)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .ignoresSafeArea()
        }
        .animation(configuration.animation, value: center.current?.id)
    }

    /// Mirrors Ekkos' Dynamic Island vertical alignment without requiring UIKit window inspection.
    private func topOffset(for item: HaloItem, in proxy: GeometryProxy) -> CGFloat {
        item.layout.topSpacing + max((proxy.safeAreaInsets.top - Layout.standardIslandSafeAreaTop), 0)
    }
}

private extension HaloHostModifier {
    enum Layout {
        static let standardIslandSafeAreaTop: CGFloat = 59
    }
}
