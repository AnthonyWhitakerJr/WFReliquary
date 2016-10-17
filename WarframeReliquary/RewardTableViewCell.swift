//
//  RewardTableViewCell.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/17/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class RewardTableViewCell: UITableViewCell {

//    @IBOutlet weak var rewardNameLabel: UILabel!
    
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
//        rewardNameLabel.text = reward.item.description
        self.textLabel?.text = reward.item.description
        
        var rarityColor: UIColor
        switch reward.rarity {
        case .Common:
            rarityColor = .brown
        case .Uncommon:
            rarityColor = .lightGray
        case .Rare:
            rarityColor = .yellow
        }
        
//        rewardNameLabel.textColor = rarityColor
        self.textLabel?.textColor = rarityColor
    }

}
