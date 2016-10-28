//
//  PrimeSetComponent+CoreDataProperties.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/27/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

extension PrimeSetComponent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrimeSetComponent> {
        return NSFetchRequest<PrimeSetComponent>(entityName: "PrimeSetComponent");
    }

    @NSManaged public var numberRequired: Int16
    @NSManaged public var primePart: PrimePart
    @NSManaged public var primeSet: PrimeSet

}
