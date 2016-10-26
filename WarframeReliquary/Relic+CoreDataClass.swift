//
//  Relic+CoreDataClass.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/25/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

public class Relic: NSManagedObject, Comparable {
    
    // MARK: Properties
    public private(set) var key: Key!
    
    // MARK: - Initializers
    convenience init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?,
                     tier: Tier, name: String, isVaulted: Bool) {
        self.init(entity: entity, insertInto: context)
        self.key = Key(tier: tier, name: name)
        self.isVaulted = isVaulted
    }
    
    convenience init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?,
        key: Key, isVaulted: Bool = false) {
        self.init(entity: entity, insertInto: context, tier: key.tier, name: key.name, isVaulted: isVaulted)
    }
    
    // MARK: - Comparable
    public static func < (lhs: Relic, rhs: Relic) -> Bool {
        return lhs.key < rhs.key
    }
    
    public static func == (lhs: Relic, rhs: Relic) -> Bool {
        return lhs.key == rhs.key
    }
    
    // MARK: Key
    public struct Key : Comparable, Hashable, CustomStringConvertible {
        public let tier: Tier!
        public let name: String!
        
        public var description: String {
            return "\(tier!) \(name!)"
        }
        
        public static func < (lhs: Key, rhs: Key) -> Bool {
            if lhs.tier != rhs.tier {
                return lhs.tier < rhs.tier
            } else {
                return lhs.name < rhs.name
            }
        }
        
        public static func == (lhs: Key, rhs: Key) -> Bool {
            return lhs.tier == rhs.tier && lhs.name == rhs.name
        }
        
        public var hashValue: Int {
            return tier.hashValue ^ name.hashValue
        }
    }
}
