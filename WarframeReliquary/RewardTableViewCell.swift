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
    @IBOutlet weak var favoriteBackground: UIImageView!
    
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
        let format = odds.truncatingRemainder(dividingBy: 1) == 0 ? "%.f%%" : "%.1f%%"        
        self.dropPercentageLabel.text = String(format: format, odds)
        
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
        
        self.favoriteBackground.isHidden = !self.reward.primePart.isFavorite
    }

}
