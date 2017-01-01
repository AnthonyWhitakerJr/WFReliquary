//
//  FavoriteButton.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 11/29/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentMode = .scaleAspectFit
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        setImage(#imageLiteral(resourceName: "favoriteIcon"), for: .normal)
        setImage(#imageLiteral(resourceName: "favoriteIconSelected"), for: .selected)
    }
    
    func toggleSelected() {
        isSelected = !isSelected
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
