//
//  RelicUtils.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/14/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class RelicUtils {
    
    static func groupByTier(relics: Dictionary<Relic.Key, Relic>) -> Dictionary<Tier, [Relic]> {
        var relicTable = Dictionary<Tier, [Relic]>()
        for (key, relic) in relics {
            if relicTable[key.tier] != nil {
                relicTable[relic.key.tier]!.append(relic)
            } else {
                relicTable[relic.key.tier] = [relic]
            }
        }
        
        for (tier, _) in relicTable {
            relicTable[tier]?.sort()
        }
        
        return relicTable
    }

}
