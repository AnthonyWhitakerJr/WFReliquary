//
//  Reward.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Reward : CustomStringConvertible {
    
    private(set) var relic: Relic //Change to Relic.Key?
    private(set) var item: Item
    private(set) var rarity: Rarity
    
    var description: String {
        return "\(relic) - \(item) - \(rarity)"
    }
    
    init(relic: Relic, item: Item, rarity: Rarity) {
        self.relic = relic
        self.item = item
        self.rarity = rarity
    }
    
}
