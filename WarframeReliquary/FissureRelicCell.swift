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
    @IBOutlet weak var vaultedLabel: UILabel!
    
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
        
        vaultedLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
    }
    
    override func configureCell(relic: Relic) {
        super.configureCell(relic: relic)
        
        relicCount = 0
        relicCountLabel.text = ""
        relicCountLabel.isHidden = true
        
        relicTitleLabel.text = relic.key.description
        relicImageView.image = image(for: relic)
        
        vaultedLabel.isHidden = !relic.isVaulted
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
