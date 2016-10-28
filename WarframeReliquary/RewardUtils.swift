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
    
    static func groupByRarity(selectedRewards : [SelectedReward]) -> Dictionary<Rarity, [SelectedReward]> {
        var rewardsTable = Dictionary<Rarity, [SelectedReward]>()
        for selectedReward in selectedRewards {
            if rewardsTable[selectedReward.reward.rarity] != nil {
                rewardsTable[selectedReward.reward.rarity]!.append(selectedReward)
            } else {
                rewardsTable[selectedReward.reward.rarity] = [selectedReward]
            }
        }
        return rewardsTable
    }

    /// Returns a sorted array of unique rewards. Any duplicate rewards will have their drop odds combined.
    static func unique(selectedRewards: [SelectedReward]) -> [SelectedReward] {
        var rewardSet = Dictionary<Reward.Key, SelectedReward>()
        for selectedReward in selectedRewards {
            if rewardSet[selectedReward.reward.key] != nil {
                rewardSet[selectedReward.reward.key]!.combineDropOdds(with: selectedReward)
            } else {
                rewardSet[selectedReward.reward.key] = selectedReward
            }
        }
        return Array(rewardSet.values).sorted()
    }
    
    /// Returns an array of the rewards from the given relics. May contain duplicates
    static func rewards(for relics: [Relic]) -> [Reward] {
        var rewards = [Reward]()
        for relic in relics {
            for reward in relic.rewards! as! Set<Reward> {
                rewards.append(reward)
            }
        }
        
        return rewards
    }
    
    static func setDropOdds(for rewards: [Reward]) -> [SelectedReward] {
        var selectedRewards = [SelectedReward]()
        for reward in rewards {
            let relicQuality = reward.relic.quality
            let rewardRarity = reward.rarity
            let key = DropChance.Key(quality: relicQuality, rarity: rewardRarity)
            let dropChance = dropChances[key]
            let selectedReward = SelectedReward(reward: reward, dropChance: dropChance!)
            selectedRewards.append(selectedReward)
        }
        
        return selectedRewards
    }
    
    
    
}
