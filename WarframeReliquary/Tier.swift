//
//  Tier.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

@objc public enum Tier : Int16, Comparable, CustomStringConvertible {
    case Lith
    case Meso
    case Neo
    case Axi
    
    static let values = [Lith, Meso, Neo, Axi]
    
    public var description: String {
        switch self {
        case .Lith:
            return "Lith"
        case .Meso:
            return "Meso"
        case .Neo:
            return "Neo"
        case .Axi:
            return "Axi"
        }
    }
    
    init?(string: String) {
        switch string {
        case "Lith":
            self.init(rawValue: 0)
        case "Meso":
            self.init(rawValue: 1)
        case "Neo":
            self.init(rawValue: 2)
        case "Axi":
            self.init(rawValue: 3)
        default:
            return nil
        }
    }
    
    public static func < (lhs: Tier, rhs: Tier) -> Bool {
        return Tier.values.index(of: lhs)! < Tier.values.index(of: rhs)!
    }

}
