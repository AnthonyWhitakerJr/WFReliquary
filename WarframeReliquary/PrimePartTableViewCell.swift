//
//  PrimePartTableViewCell.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/24/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class PrimePartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var partImageView: UIImageView!
    @IBOutlet weak var partNameLabel: UILabel!
    
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
        favoriteButton.isSelected = primePart.isFavorite
        
        var imageName: String
        if !primePart.imageName.isBlank {
            imageName = primePart.imageName
        } else {
            imageName = primePart.component!.primeSet.imageName
        }
        
        self.partImageView.image = UIImage(named: imageName)
    }

    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        primePart.isFavorite = favoriteButton.isSelected
        
        do {
            try primePart.managedObjectContext?.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

}
