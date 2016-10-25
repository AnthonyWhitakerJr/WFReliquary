//
//  Reward.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

//import Foundation
//
//class Reward : Comparable, CustomStringConvertible, Hashable {
//    
//    private(set) var relic: Relic //Change to Relic.Key?
//    private(set) var item: Item
//    private(set) var rarity: Rarity
//    private(set) var dropOdds: Double?
//
//    var description: String {
//        return "\(relic) - \(item) - \(rarity)"
//    }
//    
//    var hashValue: Int {
//        return rarity.hashValue ^ item.hashValue
//    }
//    
//    init(relic: Relic, item: Item, rarity: Rarity) {
//        self.relic = relic
//        self.item = item
//        self.rarity = rarity
//    }
//    
//    convenience init(from csv: Dictionary<String, String>, relics: Dictionary<Relic.Key, Relic>, items: Dictionary<String, Item>) {
//        let itemName = csv["item"]!.capitalized
//        let tier = Tier(rawValue: csv["tier"]!.capitalized)
//        let type = csv["type"]!
//        let key = Relic.Key(tier: tier, name: type)
//        let rarity = Rarity(string: csv["rarity"]!.capitalized)
//        
//        let relic = relics[key]!
//        let item = items[itemName]!
//        
//        self.init(relic: relic, item: item, rarity: rarity!)
//    }
//    
//    func setDropOdds(dropChance: DropChance) {
//        dropOdds = dropChance.chance(for: rarity) / Double(rarity.amountPerRelic)
//    }
//    
//    func updateDropOdds(reward: Reward) {
//        guard self == reward else { return }
//        
//        
//    }
//    
//    // MARK: - Comparable
//    static func < (lhs: Reward, rhs: Reward) -> Bool {
//        if lhs.rarity != rhs.rarity {
//            return lhs.rarity < rhs.rarity
//        } else {
//            return lhs.item < rhs.item
//        }
//    }
//    
//    static func == (lhs: Reward, rhs: Reward) -> Bool {
//        return lhs.rarity == rhs.rarity && lhs.item == rhs.item
//    }
//    
//}
