//
//  DropChance.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/17/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class DropChance: CustomStringConvertible {
    
    let quality: Quality
    let common: Double
    let uncommon: Double
    let rare: Double
    
    var description : String {
        return "\(quality): \(common*100)%, \(uncommon*100)%, \(rare*100)%"
    }
    
    init(quality: Quality, common: Double, uncommon: Double, rare: Double) {
        self.quality = quality
        self.common = common
        self.uncommon = uncommon
        self.rare = rare
    }
    
    func chance(for rarity: Rarity) -> Double {
        var chance: Double
        switch rarity {
        case .Common:
            chance = common
        case .Uncommon:
            chance = uncommon
        case .Rare:
            chance = rare
        }
        return chance
    }
}
