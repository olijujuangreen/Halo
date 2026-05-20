//
//  HaloTapModifier.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import SwiftUI

struct HaloTapModifier: ViewModifier {
    let action: (@MainActor () -> Void)?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let action {
            content.onTapGesture(perform: action)
        } else {
            content
        }
    }
}
