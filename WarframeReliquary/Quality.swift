//
//  Quality.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/17/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

enum Quality: String, Comparable {
    case Intact
    case Exceptional
    case Flawless
    case Radiant
    
    static let values = [Intact, Exceptional, Flawless, Radiant]
    
    static func < (lhs: Quality, rhs: Quality) -> Bool {
        return Quality.values.index(of: lhs)! < Quality.values.index(of: rhs)!
    }
}
