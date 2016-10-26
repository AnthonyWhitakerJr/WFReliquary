//
//  SelectedRelicCell.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/15/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class SelectedRelicCell: RelicCell {

    @IBOutlet weak var relicImageView: UIImageView!
    @IBOutlet weak var relicTitleLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5.0
        
        relicTitleLabel.layer.cornerRadius = 5.0
        relicTitleLabel.layer.masksToBounds = true
        
    }
    
    override func configureCell(relic: Relic) {
        super.configureCell(relic: relic)
        
        relicTitleLabel.text = relic.key.description
        relicImageView.image = image(for: relic)
        
        if relic.isVaulted {
            relicTitleLabel.backgroundColor = vaultedRelicColor
        } else {
            relicTitleLabel.backgroundColor = UIColor.clear
        }
    }
}
