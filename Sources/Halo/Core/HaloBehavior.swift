//
//  HaloBehavior.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

/// Controls how long a presented halo item remains active.
public enum HaloBehavior: Equatable, Sendable {
    case manual
    case autoDismiss(after: Duration)

    public static let `default`: Self = .manual
}
