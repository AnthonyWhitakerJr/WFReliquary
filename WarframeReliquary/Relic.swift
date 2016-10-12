//
//  Relic.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Relic : Comparable, CustomStringConvertible {
    
    // MARK: Properties
    private(set) var isRetired: Bool!
    let key: Key!
    
    var description: String {
        return key.description
    }
    
    // MARK: Key
    struct Key : Comparable, Hashable, CustomStringConvertible {
        let tier: Tier!
        let name: String!
        
        var description: String {
            return "\(tier!) \(name!)"
        }
        
        static func < (lhs: Key, rhs: Key) -> Bool {
            if lhs.tier != rhs.tier {
                return lhs.tier < rhs.tier
            } else {
                return lhs.name < rhs.name
            }
        }
        
        static func == (lhs: Key, rhs: Key) -> Bool {
            return lhs.tier == rhs.tier && lhs.name == rhs.name
        }
        
        var hashValue: Int {
            return tier.hashValue ^ name.hashValue
        }
    }
    
    // MARK: - Initializers
    init(tier: Tier, name: String, isRetired: Bool = false) {
        self.key = Key(tier: tier, name: name)
        self.isRetired = isRetired
    }
    
    convenience init(key: Key, isRetired: Bool = false) {
        self.init(tier: key.tier, name: key.name, isRetired: isRetired)
    }
    
    // MARK: - Comparable
    static func < (lhs: Relic, rhs: Relic) -> Bool {
        return lhs.key < rhs.key
    }
    
    static func == (lhs: Relic, rhs: Relic) -> Bool {
        return lhs.key == rhs.key
    }
    
}
