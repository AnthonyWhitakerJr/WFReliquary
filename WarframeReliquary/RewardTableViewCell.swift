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
    
    @IBOutlet weak var partImage: UIImageView!
    @IBOutlet weak var partLabel: UILabel!
    @IBOutlet weak var dropPercentageLabel: UILabel!
    
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
        self.partLabel.text = reward.primePart.name
        
        let odds = reward.dropOdds!*100
        let oddsString = odds.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(round(odds)))%" : "\(round(odds * 10) / 10)%" // Add a single decimal place but only where applicable (no .0)
        self.dropPercentageLabel.text = oddsString
        
        var rarityColor: UIColor
        switch reward.rarity {
        case .Common:
            rarityColor = Constants.bronze
        case .Uncommon:
            rarityColor = Constants.silver
        case .Rare:
            rarityColor = Constants.gold
        }
        
        self.partLabel.textColor = rarityColor
    }

}
