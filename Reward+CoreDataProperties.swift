//
//  Reward+CoreDataProperties.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/25/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData
import 

extension Reward {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reward> {
        return NSFetchRequest<Reward>(entityName: "Reward");
    }

    @NSManaged public var rarity: Rarity
    @NSManaged public var primePart: PrimePart
    @NSManaged public var relic: Relic

}
