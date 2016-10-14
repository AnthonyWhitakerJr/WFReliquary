//
//  FissureRelicCell.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class FissureRelicCell: UICollectionViewCell {

    @IBOutlet weak var relicCountLabel: UILabel!
    @IBOutlet weak var relicImageView: UIImageView!
    @IBOutlet weak var relicTitleLabel: UILabel!
    
    var relic: Relic!
    var relicCount: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(relic: Relic) {
        self.relic = relic
        
        relicTitleLabel.text = self.relic.description
        relicImageView.image = image(for: relic)
    }
    
    func image(for relic: Relic) -> UIImage {
        var image: UIImage
        switch relic.key.tier! {
        case .Lith:
            image = #imageLiteral(resourceName: "Lith_Intact")
        case .Meso:
            image = #imageLiteral(resourceName: "Meso_Intact")
        case .Neo:
            image = #imageLiteral(resourceName: "Neo_Intact")
        case .Axi:
            image = #imageLiteral(resourceName: "Axi_Intact")
        }
        return image
    }
    
    func tapped() {
        relicCount = (relicCount + 1) % 5
        switch relicCount {
        case 0:
            relicCountLabel.text = ""
        default:
            relicCountLabel.text = "\(relicCount) IN USE"
        }
    }

}
