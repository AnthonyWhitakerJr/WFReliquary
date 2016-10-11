//
//  Reward.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Reward {
    
    private(set) var relic: Relic
    private(set) var item: Item
    private(set) var rarity: Rarity
    
    init(relic: Relic, item: Item, rarity: Rarity) {
        self.relic = relic
        self.item = item
        self.rarity = rarity
    }
    
}
