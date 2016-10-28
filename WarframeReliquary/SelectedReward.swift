//
//  SelectedReward.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class SelectedReward: Comparable {
    
    var reward: Reward
    var dropOdds: Double = 0
    
    init(reward: Reward) {
        self.reward = reward
    }
    
    convenience init(reward: Reward, dropChance: DropChance) {
        self.init(reward: reward)
        setDropOdds(dropChance: dropChance)
    }
    
    func setDropOdds(dropChance: DropChance) {
        dropOdds = dropChance.chance / Double(reward.rarity.amountPerRelic)
    }
    
    func combineDropOdds(with selectedReward: SelectedReward) {
        dropOdds = dropOdds + (1 - dropOdds) * selectedReward.dropOdds
    }
    
    // MARK: - Comparable
    public static func < (lhs: SelectedReward, rhs: SelectedReward) -> Bool {
        return lhs.reward < rhs.reward
    }
    
    public static func == (lhs: SelectedReward, rhs: SelectedReward) -> Bool {
        return lhs.reward == rhs.reward
    }
}
