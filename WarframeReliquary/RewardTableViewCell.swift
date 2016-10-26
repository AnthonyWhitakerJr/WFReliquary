//
//  RewardTableViewCell.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/17/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class RewardTableViewCell: UITableViewCell {
    
    var reward: Reward!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(reward: Reward) {
        self.reward = reward
        self.textLabel?.text = reward.primePart.name
        self.detailTextLabel?.text = "\(Int(round(reward.dropOdds!*100)))%" //TODO: add a single decimal place but only where applicable (no .0)
        
        var rarityColor: UIColor
        switch reward.rarity {
        case .Common:
            rarityColor = Constants.bronze
        case .Uncommon:
            rarityColor = Constants.silver
        case .Rare:
            rarityColor = Constants.gold
        }
        
        self.textLabel?.textColor = rarityColor
    }

}
