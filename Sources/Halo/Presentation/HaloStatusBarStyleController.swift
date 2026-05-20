//
//  HaloStatusBarStyleController.swift
//  Halo
//
//  Created by Codex on 5/20/26.
//

import SwiftUI
import UIKit

struct HaloStatusBarStyleController: UIViewControllerRepresentable {
    let style: UIStatusBarStyle

    func makeUIViewController(context: Context) -> Controller {
        Controller(style: style)
    }

    func updateUIViewController(_ controller: Controller, context: Context) {
        controller.style = style
    }
}

extension HaloStatusBarStyleController {
    final class Controller: UIViewController {
        var style: UIStatusBarStyle {
            didSet {
                setNeedsStatusBarAppearanceUpdate()
                parent?.setNeedsStatusBarAppearanceUpdate()
            }
        }

        init(style: UIStatusBarStyle) {
            self.style = style
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }

        override var preferredStatusBarStyle: UIStatusBarStyle {
            style
        }

        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            parent?.setNeedsStatusBarAppearanceUpdate()
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            parent?.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
