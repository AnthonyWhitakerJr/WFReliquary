//
//  RewardTableViewCell.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/17/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class RewardTableViewCell: UITableViewCell {
    
    var selectedReward: SelectedReward!
    
    @IBOutlet weak var partImage: UIImageView!
    @IBOutlet weak var partLabel: UILabel!
    @IBOutlet weak var dropPercentageLabel: UILabel!
    @IBOutlet weak var favoriteBackground: UIImageView!
    @IBOutlet weak var vaultedLabel: UILabel!
    
    @IBOutlet weak var ducatValueLabel: UILabel!
    @IBOutlet weak var ducatImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vaultedLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(selectedReward: SelectedReward) {
        self.selectedReward = selectedReward
        self.partLabel.text = selectedReward.reward.primePart.name
        
//        let odds = selectedReward.dropOdds * 100
//        let format = odds.truncatingRemainder(dividingBy: 1) < 0.1 ? "%.f%%" : "%.1f%%"
//        self.dropPercentageLabel.text = String(format: format, odds)
        
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "Ducat")
        attachment.bounds = CGRect(x: 0.0, y: dropPercentageLabel.font.descender, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        let text:NSMutableAttributedString = NSMutableAttributedString(string: "\(selectedReward.reward.primePart.ducatValue)")
        text.append(attachmentString)
        
        self.dropPercentageLabel.attributedText = text
        
        
        var rarityColor: UIColor
        switch selectedReward.reward.rarity {
        case .Common:
            rarityColor = Constants.bronze
        case .Uncommon:
            rarityColor = Constants.silver
        case .Rare:
            rarityColor = Constants.gold
        }
        
        self.partLabel.textColor = rarityColor
        
        self.favoriteBackground.isHidden = !self.selectedReward.reward.primePart.isFavorite
        
        var imageName: String
        if !selectedReward.reward.primePart.imageName.isBlank {
            imageName = selectedReward.reward.primePart.imageName
        } else {
            imageName = selectedReward.reward.primePart.component!.primeSet.imageName
        }
        
        self.partImage.image = UIImage(named: imageName)
        
        vaultedLabel.isHidden = !selectedReward.reward.primePart.isVaulted
    }

    func toggleDetails(option: Bool) {
        switch option {
        case false: // Drop Percentage
            let odds = selectedReward.dropOdds * 100
            let format = odds.truncatingRemainder(dividingBy: 1) < 0.1 ? "%.f%%" : "%.1f%%"
            self.dropPercentageLabel.text = String(format: format, odds)
        case true: // Ducat Value
            let attachment:NSTextAttachment = NSTextAttachment()
            attachment.image = #imageLiteral(resourceName: "Ducat")
            attachment.bounds = CGRect(x: 0.0, y: dropPercentageLabel.font.descender, width: attachment.image!.size.width, height: attachment.image!.size.height)
            let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
            let text:NSMutableAttributedString = NSMutableAttributedString(string: "\(selectedReward.reward.primePart.ducatValue)")
            text.append(attachmentString)
            
            self.dropPercentageLabel.attributedText = text
        }
        
    }
}
