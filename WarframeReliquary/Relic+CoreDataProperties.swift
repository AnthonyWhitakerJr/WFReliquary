//
//  Relic+CoreDataProperties.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/25/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

extension Relic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Relic> {
        return NSFetchRequest<Relic>(entityName: "Relic");
    }

    @NSManaged public var isVaulted: Bool
    @NSManaged public var name: String
    @NSManaged public var tier: Tier
    @NSManaged public var quality: Quality
    @NSManaged public var rewards: NSSet?

}

// MARK: Generated accessors for rewards
extension Relic {

    @objc(addRewardsObject:)
    @NSManaged public func addToRewards(_ value: Reward)

    @objc(removeRewardsObject:)
    @NSManaged public func removeFromRewards(_ value: Reward)

    @objc(addRewards:)
    @NSManaged public func addToRewards(_ values: NSSet)

    @objc(removeRewards:)
    @NSManaged public func removeFromRewards(_ values: NSSet)

}
