//
//  DropChance+CoreDataClass.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

@objc(DropChance)
public class DropChance: NSManagedObject {

    public var key: Key {
        return Key(quality: quality, rarity: rarity)
    }
    
    convenience init(quality: Quality, rarity: Rarity, chance: Double, into context: NSManagedObjectContext) {
        self.init(context: context)
        self.quality = quality
        self.rarity = rarity
        self.chance = chance
    }
    
    // MARK: Key
    public struct Key : CustomStringConvertible, Equatable, Hashable {
        public let quality: Quality!
        public let rarity: Rarity!
        
        public var description: String {
            return "\(quality), \(rarity)"
        }
        
        public static func == (lhs: Key, rhs: Key) -> Bool {
            return lhs.quality == rhs.quality && lhs.rarity == rhs.rarity
        }
        
        public var hashValue: Int {
            return quality.hashValue ^ rarity.hashValue
        }
    }
}
