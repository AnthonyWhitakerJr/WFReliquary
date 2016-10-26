//
//  PrimePartTableViewCell.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/24/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class PrimePartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var partNameLabel: UILabel!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    var primePart: PrimePart!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(primePart: PrimePart) {
        self.primePart = primePart
        partNameLabel.text = primePart.name
        favoriteSwitch.setOn(primePart.isFavorite, animated: false)
    }

}
