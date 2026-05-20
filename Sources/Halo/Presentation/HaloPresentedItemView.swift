//
//  HaloPresentedItemView.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import SwiftUI

struct HaloPresentedItemView: View {
    let center: HaloCenter
    let item: HaloItem
    let configuration: HaloHostConfiguration

    var body: some View {
        item.content.resolve()
            .padding(.horizontal, item.layout.contentHorizontalPadding)
            .padding(.bottom, item.layout.contentBottomPadding)
            .frame(maxWidth: item.layout.maxWidth ?? .infinity)
            .frame(height: item.layout.height, alignment: .bottom)
            .background(islandShape.fill(configuration.surfaceFill))
            .clipShape(islandShape)
            .contentShape(islandShape)
            .geometryGroup()
            .modifier(HaloTapModifier(action: item.interaction.onTap))
            .modifier(
                HaloDragDismissModifier(
                    isEnabled: item.interaction.dragToDismiss,
                    center: center,
                    itemID: item.id,
                    threshold: configuration.dragDismissThreshold
                )
            )
    }

    private var islandShape: ConcentricRectangle {
        ConcentricRectangle(
            corners: .concentric(minimum: .fixed(item.layout.resolvedCornerRadius)),
            isUniform: true
        )
    }
}
