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
		content
			.background(statusBarStyleController)
			.overlay(alignment: .top, content: overlay)
			.animation(configuration.animation, value: center.current?.id)
	}

	private func overlay() -> some View {
		HostOverlay(center: center, configuration: configuration)
	}

	@ViewBuilder
	private var statusBarStyleController: some View {
		if center.current != nil {
			HaloStatusBarStyleController(style: .default)
				.frame(width: 0, height: 0)
		}
	}
}

private struct HostOverlay: View {
	let center: HaloCenter
	let configuration: HaloHostConfiguration

	var body: some View {
		GeometryReader { proxy in
			ZStack(alignment: .top) {
				if let item = center.current {
					HaloPresentedItemContainer(
						center: center,
						item: item,
						configuration: configuration,
						proxy: proxy
					)
					.zIndex(1)
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		}
		.ignoresSafeArea()
	}
}

private struct HaloPresentedItemContainer: View {
	let center: HaloCenter
	let item: HaloItem
	let configuration: HaloHostConfiguration
	let proxy: GeometryProxy

	var body: some View {
		HaloPresentedItemView(
			center: center,
			item: item,
			configuration: configuration
		)
		.padding(.horizontal, item.layout.horizontalInset)
		.offset(y: topOffset)
		.transition(.scale(scale: 0.34, anchor: .top).combined(with: .opacity))
	}

	/// Mirrors Ekkos' Dynamic Island vertical alignment without requiring UIKit window inspection.
	private var topOffset: CGFloat {
		item.layout.topSpacing + max((proxy.safeAreaInsets.top - Layout.standardIslandSafeAreaTop), 0)
	}
}

private enum Layout {
	static let standardIslandSafeAreaTop: CGFloat = 59
}
