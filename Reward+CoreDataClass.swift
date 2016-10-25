//
//  Reward+CoreDataClass.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/25/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

public class Reward: NSManagedObject, Comparable {
    private(set) var dropOdds: Double?
    
    override public var description: String {
        return "\(relic) - \(primePart) - \(rarity)"
    }
    
    override public var hashValue: Int {
        return rarity.hashValue ^ primePart.hashValue
    }
    
    init(relic: Relic, primePart: PrimePart, rarity: Rarity) {
        self.relic = relic
        self.primePart = primePart
        self.rarity = rarity
    }
    
    convenience init(from csv: Dictionary<String, String>, relics: Dictionary<Relic.Key, Relic>, primeParts: Dictionary<String, PrimePart>) {
        let partName = csv["item"]!.capitalized
        let tier = Tier(string: csv["tier"]!.capitalized)
        let type = csv["type"]!
        let key = Relic.Key(tier: tier, name: type)
        let rarity = Rarity(string: csv["rarity"]!.capitalized)
        
        let relic = relics[key]!
        let primePart = primeParts[partName]!
        
        self.init(relic: relic, primePart: primePart, rarity: rarity!)
    }
    
    func setDropOdds(dropChance: DropChance) {
        dropOdds = dropChance.chance(for: rarity) / Double(rarity.amountPerRelic)
    }
    
    func updateDropOdds(reward: Reward) {
        guard self == reward else { return }
        
        
    }
    
    // MARK: - Comparable
    public static func < (lhs: Reward, rhs: Reward) -> Bool {
        if lhs.rarity != rhs.rarity {
            return lhs.rarity < rhs.rarity
        } else {
            return lhs.primePart < rhs.primePart
        }
    }
    
    public static func == (lhs: Reward, rhs: Reward) -> Bool {
        return lhs.rarity == rhs.rarity && lhs.primePart == rhs.primePart
    }
}
