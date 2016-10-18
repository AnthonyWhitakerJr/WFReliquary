//
//  Rarity.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

enum Rarity : String, Comparable {
    case Common
    case Uncommon
    case Rare
    
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
    
    static let values = [Common, Uncommon, Rare]
    
    static func < (lhs: Rarity, rhs: Rarity) -> Bool {
        return Rarity.values.index(of: lhs)! < Rarity.values.index(of: rhs)!
    }
}
