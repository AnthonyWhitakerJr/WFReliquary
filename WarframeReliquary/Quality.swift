//
//  Quality.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/17/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

@objc public enum Quality: Int16, Comparable {
    case Intact
    case Exceptional
    case Flawless
    case Radiant
    
    static let values = [Intact, Exceptional, Flawless, Radiant]
    
    public var description: String {
        switch self {
        case .Intact:
            return "Intact"
        case .Exceptional:
            return "Exceptional"
        case .Flawless:
            return "Flawless"
        case .Radiant:
            return "Radiant"
        }
    }
    
    init?(string: String) {
        switch string {
        case "Intact":
            self.init(rawValue: 0)
        case "Exceptional":
            self.init(rawValue: 1)
        case "Flawless":
            self.init(rawValue: 2)
        case "Radiant":
            self.init(rawValue: 3)
        default:
            return nil
        }
    }
    
    public static func < (lhs: Quality, rhs: Quality) -> Bool {
        return Quality.values.index(of: lhs)! < Quality.values.index(of: rhs)!
    }
}
