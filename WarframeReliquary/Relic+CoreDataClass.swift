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
    convenience init(tier: Tier, name: String, isVaulted: Bool, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.key = Key(tier: tier, name: name)
        self.isVaulted = isVaulted
    }
    
    convenience init(key: Key, isVaulted: Bool, insertInto context: NSManagedObjectContext) {
        self.init(tier: key.tier, name: key.name, isVaulted: isVaulted, insertInto: context)
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
