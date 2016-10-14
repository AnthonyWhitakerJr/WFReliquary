//
//  RewardsUtils.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class RewardUtils {
    
    enum RewardGroupOtions {
        case Relic
        case Item
        case Rarity
    }
    
    static func createRewardsTable(groupedBy option: RewardGroupOtions, rewards: [Reward]) {
        
    }
    
    static func groupByRelic(rewards : [Reward]) -> Dictionary<Relic.Key, [Reward]> {
        var rewardsTable = Dictionary<Relic.Key, [Reward]>()
        for reward in rewards {
            if rewardsTable[reward.relic.key] != nil {
                rewardsTable[reward.relic.key]!.append(reward)
            } else {
                rewardsTable[reward.relic.key] = [reward]
            }
        }
        return rewardsTable
    }
    
    static func groupByTier(relics: Dictionary<Relic.Key, Relic>) -> Dictionary<Tier, [Relic]> {
        var relicTable = Dictionary<Tier, [Relic]>()
        for (key, relic) in relics {
            if relicTable[key.tier] != nil {
                relicTable[key.tier]!.append(relic)
            } else {
                relicTable[key.tier] = [relic]
            }
        }
        return relicTable
    }
    
}
