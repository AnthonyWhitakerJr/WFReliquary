//
//  CSVReader.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class CsvReader {
    
    static let items = parseItemCsv()
    static let relics = parseRelicCsv()
    static let rewards = parseRewardCsv(relics: relics, items: items)
    
    static func parseItemCsv() -> Dictionary<String, Item> {
        var items = Dictionary<String, Item>()
        let path = Bundle.main.path(forResource: "Items", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let name = row["name"]!
                let isVaulted = Bool.init(row["isVaulted"]!.lowercased())!
                let item = Item(name: name, isVaulted: isVaulted)
                
                items[name] = item
                
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return items
    }
    
    static func parseRelicCsv() -> Dictionary<Relic.Key, Relic> {
        var relics = Dictionary<Relic.Key, Relic>()
        let path = Bundle.main.path(forResource: "Relics", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let tier = Tier(rawValue: row["tier"]!)
                let type = row["type"]!
                let key = Relic.Key(tier: tier, name: type)
                let isVaulted = Bool.init(row["isVaulted"]!.lowercased())!
                let relic = Relic(key: key, isVaulted: isVaulted)
                
                relics[key] = relic
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return relics
    }
    
    static func parseRewardCsv(relics: Dictionary<Relic.Key, Relic>, items: Dictionary<String, Item>) -> [Reward] {
        var rewards = [Reward]()
        let path = Bundle.main.path(forResource: "Rewards", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let itemName = row["item"]!.capitalized
                let tier = Tier(rawValue: row["tier"]!.capitalized)
                let type = row["type"]!
                let key = Relic.Key(tier: tier, name: type)
                let rarity = Rarity(rawValue: row["rarity"]!.capitalized)
                
                let relic = relics[key]!
                let item = items[itemName]!
                
                let reward = Reward(relic: relic, item: item, rarity: rarity!)
                
                rewards.append(reward)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return rewards
    }
    
    static func parseDropChanceCsv() -> Dictionary<DropChance.Key, DropChance> {
        var dropChances = Dictionary<DropChance.Key, DropChance>()
        let path = Bundle.main.path(forResource: "DropChances", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let quality = Quality(rawValue: row["Quality"]!)
                let common = Double(row["Common"]!)
                let uncommon = Double(row["Uncommon"]!)
                let rare = Double(row["Rare"]!)
                
                let commonChance = DropChance(quality: quality!, rarity: .Common, chance: common!)
                let uncommonChance = DropChance(quality: quality!, rarity: .Uncommon, chance: uncommon!)
                let rareChance = DropChance(quality: quality!, rarity: .Rare, chance: rare!)

                dropChances[commonChance.key] = commonChance
                dropChances[uncommonChance.key] = uncommonChance
                dropChances[rareChance.key] = rareChance
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return dropChances
    }

}
