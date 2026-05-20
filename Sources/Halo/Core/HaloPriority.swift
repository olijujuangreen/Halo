//
//  HaloPriority.swift
//  Halo
//
//  Created by Olijujuan Green on 5/19/26.
//

/// Relative importance for replacement and queue ordering.
public enum HaloPriority: Int, Comparable, Sendable {
    case low = 0
    case normal = 1
    case high = 2
    case critical = 3

    public static func < (lhs: HaloPriority, rhs: HaloPriority) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
