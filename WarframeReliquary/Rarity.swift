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
    
    static func < (lhs: Rarity, rhs: Rarity) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
