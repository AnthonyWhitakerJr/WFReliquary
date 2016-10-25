//
//  Rarity.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

@objc public enum Rarity : Int16, Comparable, CustomStringConvertible {
    case Common
    case Uncommon
    case Rare
    
    public static let values = [Common, Uncommon, Rare]
    
    var amountPerRelic: Int {
        switch self {
        case .Common:
            return 3
        case .Uncommon:
            return 2
        case .Rare:
            return 1
        }
    }
    
    public var description: String {
        switch self {
        case .Common:
            return "Common"
        case .Uncommon:
            return "Uncommon"
        case .Rare:
            return "Rare"
        }
    }
    
    init?(string: String) {
        switch string {
        case "Common":
            self.init(rawValue: 0)
        case "Uncommon":
            self.init(rawValue: 1)
        case "Rare":
            self.init(rawValue: 2)
        default:
            return nil
        }
    }
    
    public static func < (lhs: Rarity, rhs: Rarity) -> Bool {
        return Rarity.values.index(of: lhs)! < Rarity.values.index(of: rhs)!
    }
}
