//
//  DropChance+CoreDataProperties.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData


extension DropChance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DropChance> {
        return NSFetchRequest<DropChance>(entityName: "DropChance");
    }

    @NSManaged public var quality: Quality
    @NSManaged public var rarity: Rarity
    @NSManaged public var chance: Double

}
