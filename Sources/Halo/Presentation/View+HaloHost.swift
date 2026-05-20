//
//  View+HaloHost.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

import SwiftUI

public extension View {
    @MainActor
    func haloHost(
        _ center: HaloCenter,
        configuration: HaloHostConfiguration = .default
    ) -> some View {
        modifier(
            HaloHostModifier(
                center: center,
                configuration: configuration
            )
        )
    }
}
