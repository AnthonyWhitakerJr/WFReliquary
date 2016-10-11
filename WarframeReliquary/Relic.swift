//
//  Relic.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Relic {
    private(set) var tier: Tier!
    private(set) var name: String!
    private(set) var isRetired: Bool!
    
    init(tier: Tier, name: String, isRetired: Bool = false) {
        self.tier = tier
        self.name = name
        self.isRetired = isRetired
    }
    
    
}
