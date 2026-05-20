//
//  HaloLayout.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import SwiftUI

/// Size and spacing for an expanded Dynamic Island surface.
///
/// Halo content is bottom-aligned by default so callers can opt into extra cutout clearance only when needed.
public struct HaloLayout: Equatable, Sendable {
	var resolvedCornerRadius: CGFloat { cornerRadius ?? 30 }

    public var horizontalInset: CGFloat
    public var height: CGFloat
    public var maxWidth: CGFloat?
    public var cornerRadius: CGFloat?
    public var topSpacing: CGFloat
    public var contentHorizontalPadding: CGFloat
    public var contentBottomPadding: CGFloat

    public init(
        horizontalInset: CGFloat = 10,
        height: CGFloat = 90,
        maxWidth: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        topSpacing: CGFloat = 11,
        contentHorizontalPadding: CGFloat = 20,
        contentBottomPadding: CGFloat = 12
    ) {
        self.horizontalInset = horizontalInset
        self.height = height
        self.maxWidth = maxWidth
        self.cornerRadius = cornerRadius
        self.topSpacing = topSpacing
        self.contentHorizontalPadding = contentHorizontalPadding
        self.contentBottomPadding = contentBottomPadding
    }

    public static let `default` = HaloLayout()

    public static var cameraCutoutAvoiding: HaloLayout {
        HaloLayout().avoidingCameraCutout()
    }

    public func avoidingCameraCutout(
        when shouldAvoid: Bool = true,
        minimumHeight: CGFloat = 104
    ) -> HaloLayout {
        guard shouldAvoid else { return self }

        var layout = self
        layout.height = max(layout.height, minimumHeight)
        return layout
    }
}
