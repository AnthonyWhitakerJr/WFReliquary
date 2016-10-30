//
//  SelectedRelicCell.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/15/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class SelectedRelicCell: UICollectionViewCell {

    @IBOutlet weak var relicImageView: UIImageView!
    @IBOutlet weak var relicTitleLabel: UILabel!
    @IBOutlet weak var vaultedLabel: UILabel!
    
    var selectedRelic: SelectedRelic!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5.0
        
        relicTitleLabel.layer.cornerRadius = 5.0
        relicTitleLabel.layer.masksToBounds = true
        
        vaultedLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
    }
    
    func configureCell(selectedRelic: SelectedRelic) {
        self.selectedRelic = selectedRelic
        
        relicTitleLabel.text = selectedRelic.relic.key.description
        relicImageView.image = image(for: selectedRelic)
        
        vaultedLabel.isHidden = !selectedRelic.relic.isVaulted
    }
    
    func image(for selectedRelic: SelectedRelic) -> UIImage {
        return UIImage(named: "\(selectedRelic.relic.key.tier!.description)_\(selectedRelic.quality.description)")!
    }
}
