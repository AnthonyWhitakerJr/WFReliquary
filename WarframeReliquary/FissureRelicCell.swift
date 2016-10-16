//
//  FissureRelicCell.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class FissureRelicCell: RelicCell {
    
    @IBOutlet weak var relicCountLabel: UILabel!
    @IBOutlet weak var relicImageView: UIImageView!
    @IBOutlet weak var relicTitleLabel: UILabel!
    
    var relicCount: Int = 0
    
    let labelBackgroundColor = UIColor(red: 219.0/255, green: 221.0/255, blue: 221.0/255, alpha: 0.8)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.cornerRadius = 5.0
        
        relicCountLabel.layer.cornerRadius = 5.0
        relicCountLabel.layer.masksToBounds = true
        
        relicTitleLabel.layer.cornerRadius = 5.0
        relicTitleLabel.layer.masksToBounds = true

    }
    
    override func configureCell(relic: Relic) {
        super.configureCell(relic: relic)
        
        relicCount = 0
        relicCountLabel.text = ""
        relicCountLabel.isHidden = true
        
        relicTitleLabel.text = relic.description
        relicImageView.image = image(for: relic)
        
        if relic.isVaulted! {
            relicTitleLabel.backgroundColor = vaultedRelicColor
        } else {
            relicTitleLabel.backgroundColor = labelBackgroundColor
        }
    }
    
    func update(count: Int) {
        relicCount = count
        switch relicCount {
        case 0:
            relicCountLabel.text = ""
            relicCountLabel.isHidden = true
        default:
            relicCountLabel.isHidden = false
            relicCountLabel.text = "\(relicCount) IN USE"
        }
    }
    
}
