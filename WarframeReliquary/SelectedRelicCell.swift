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
    @IBOutlet weak var vaultedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5.0
        
        relicTitleLabel.layer.cornerRadius = 5.0
        relicTitleLabel.layer.masksToBounds = true
        
        vaultedLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
    }
    
    override func configureCell(relic: Relic) {
        super.configureCell(relic: relic)
        
        relicTitleLabel.text = relic.key.description
        relicImageView.image = image(for: relic)
        
        vaultedLabel.isHidden = !relic.isVaulted
    }
}
