//
//  PrimePart+CoreDataProperties.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/25/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

extension PrimePart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrimePart> {
        return NSFetchRequest<PrimePart>(entityName: "PrimePart");
    }

    @NSManaged public var associatedRewards: NSSet?
    @NSManaged public var component: PrimeSetComponent?
    @NSManaged public var count: Int32
    @NSManaged public var ducatValue: Int16
    @NSManaged public var imageName: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var isVaulted: Bool
    @NSManaged public var name: String

}

// MARK: Generated accessors for associatedRewards
extension PrimePart {

    @objc(addAssociatedRewardsObject:)
    @NSManaged public func addToAssociatedRewards(_ value: Reward)

    @objc(removeAssociatedRewardsObject:)
    @NSManaged public func removeFromAssociatedRewards(_ value: Reward)

    @objc(addAssociatedRewards:)
    @NSManaged public func addToAssociatedRewards(_ values: NSSet)

    @objc(removeAssociatedRewards:)
    @NSManaged public func removeFromAssociatedRewards(_ values: NSSet)

}
