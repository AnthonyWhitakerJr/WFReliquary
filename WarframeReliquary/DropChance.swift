//
//  DropChance.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/17/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class DropChance: CustomStringConvertible, Equatable, Hashable {
    
    let chance: Double
    let key: Key
    
    var quality: Quality {
        return key.quality
    }
    var rarity: Rarity {
        return key.rarity
    }
    
    var description : String {
        return "\(key): \(chance*100)%"
    }
    
    var hashValue: Int {
        return key.hashValue
    }
    
    init(quality: Quality, rarity: Rarity, chance: Double) {
        self.key = Key(quality: quality, rarity: rarity)
        self.chance = chance
    }
    
    static func == (lhs: DropChance, rhs: DropChance) -> Bool {
        return lhs.key == rhs.key
    }
    
    // MARK: Key
    struct Key : CustomStringConvertible, Equatable, Hashable {
        let quality: Quality!
        let rarity: Rarity!
        
        var description: String {
            return "\(quality), \(rarity)"
        }
        
        static func == (lhs: Key, rhs: Key) -> Bool {
            return lhs.quality == rhs.quality && lhs.rarity == rhs.rarity
        }
        
        var hashValue: Int {
            return quality.hashValue ^ rarity.hashValue
        }
    }

}
