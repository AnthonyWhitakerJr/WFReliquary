//
//  Tier.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

enum Tier : String, Comparable {
    case Lith
    case Meso
    case Neo
    case Axi
    
    static func < (lhs: Tier, rhs: Tier) -> Bool {
            return lhs.rawValue < rhs.rawValue
    }

}
