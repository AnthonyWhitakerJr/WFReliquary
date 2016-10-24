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
    
    private static let dropChances = CsvReader.parseDropChanceCsv()
    
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
    
    static func groupByRariry(rewards : [Reward]) -> Dictionary<Rarity, [Reward]> {
        var rewardsTable = Dictionary<Rarity, [Reward]>()
        for reward in rewards {
            if rewardsTable[reward.rarity] != nil {
                rewardsTable[reward.rarity]!.append(reward)
            } else {
                rewardsTable[reward.rarity] = [reward]
            }
        }
        return rewardsTable
    }
    
    /// Returns a sorted array of the unique rewards from the given relics.
    static func rewards(for relics: [Relic], from rewardsByRelic: Dictionary<Relic.Key, [Reward]>) -> [Reward] {
        var rewardSet = Set<Reward>()
        for relic in relics {
            for reward in rewardsByRelic[relic.key]! {
                rewardSet.insert(reward)
            }
        }
        return rewardSet.sorted()
    }
    
    static func setDropOdds(for rewards: inout [Reward]) {
        for reward in rewards {
            let relicQuality = reward.relic.quality
            let dropChance = dropChances[relicQuality]
            reward.setDropOdds(dropChance: dropChance!)
        }
    }
    

    
}
