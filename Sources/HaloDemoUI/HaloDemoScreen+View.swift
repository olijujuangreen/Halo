//
//  HaloDemoScreen+View.swift
//  HaloDemoUI
//
//  Created by Olijujuan Green on 5/19/26.
//

import Halo
import SwiftUI

extension HaloDemoScreen: View {
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    statusHeader
                    actionList
                }
                .padding(20)
            }
            .navigationTitle("Halo Demo")
            .toolbar {
                Button("Dismiss All", action: halo.dismissAll)
            }
        }
        .haloHost(halo)
    }

    private var statusHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("SwiftUI presentation kernel")
                .font(.title2.weight(.semibold))

            Text("Tap an action to present type-erased content in the root Halo host. Drag a visible halo upward to dismiss it.")
                .font(.callout)
                .foregroundStyle(.secondary)

            Label("Tap count: \(tapCount)", systemImage: "hand.tap.fill")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var actionList: some View {
        VStack(alignment: .leading, spacing: 18) {
            ForEach(actionSections, content: actionSection)
        }
    }

    private func actionSection(_ section: ActionSection) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(section.title)
                .font(.headline)

            VStack(spacing: 10) {
                ForEach(section.actions, content: actionButton)
            }
        }
    }

    private func actionButton(for action: DemoAction) -> some View {
        Button {
            perform(action)
        } label: {
            HStack(spacing: 12) {
                Image(systemName: action.symbol)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.blue)
                    .frame(width: 32)

                VStack(alignment: .leading, spacing: 3) {
                    Text(action.title)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.primary)

                    Text(action.subtitle)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.tertiary)
            }
            .padding(14)
            .frame(minHeight: 72, alignment: .leading)
            .background(
                .background.secondary,
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
        }
        .buttonStyle(.plain)
    }

    struct PresentedHaloContent: View {
        let sample: HaloSample

        var body: some View {
            HStack(spacing: 12) {
                Image(systemName: sample.symbol)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(.white, sample.tint)
                    .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 4) {
                    Text(sample.title)
                        .font(.callout.weight(.semibold))
                        .foregroundStyle(.white)

                    Text(sample.message)
                        .font(.caption)
                        .lineLimit(2)
                        .foregroundStyle(.white.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview("Halo Demo") {
    HaloDemoScreen()
}
