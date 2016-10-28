//
//  PrimeSet+CoreDataProperties.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/27/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

extension PrimeSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrimeSet> {
        return NSFetchRequest<PrimeSet>(entityName: "PrimeSet");
    }

    @NSManaged public var imageName: String
    @NSManaged public var name: String
    @NSManaged public var primeSetComponents: NSSet?

}

// MARK: Generated accessors for primeSetComponents
extension PrimeSet {

    @objc(addPrimeSetComponentsObject:)
    @NSManaged public func addToPrimeSetComponents(_ value: PrimeSetComponent)

    @objc(removePrimeSetComponentsObject:)
    @NSManaged public func removeFromPrimeSetComponents(_ value: PrimeSetComponent)

    @objc(addPrimeSetComponents:)
    @NSManaged public func addToPrimeSetComponents(_ values: NSSet)

    @objc(removePrimeSetComponents:)
    @NSManaged public func removeFromPrimeSetComponents(_ values: NSSet)

}
