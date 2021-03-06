//
//  RewardsUtils.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

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
    
    /// Returns an array of rewards from the given relics. May contain duplicates
    static func rewards(for selectedRelics: [SelectedRelic], from context: NSManagedObjectContext) -> [SelectedReward] {
        var dropChances = Dictionary<DropChance.Key, DropChance>()
        let fetchRequest: NSFetchRequest<DropChance> = DropChance.fetchRequest()
        var selectedRewards = [SelectedReward]()
        
        do {
            let results = try context.fetch(fetchRequest)
            dropChances = results.toDictionary{ $0.key }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        for selectedRelic in selectedRelics {
            for reward in selectedRelic.relic.rewards! as! Set<Reward> {
                let relicQuality = selectedRelic.quality
                let rewardRarity = reward.rarity
                let key = DropChance.Key(quality: relicQuality, rarity: rewardRarity)
                let dropChance = dropChances[key]
                let selectedReward = SelectedReward(reward: reward, dropChance: dropChance!)
                selectedRewards.append(selectedReward)
            }
            
        }
        
        return selectedRewards
    }
    
}
