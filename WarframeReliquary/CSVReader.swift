//
//  CSVReader.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class CSVReader {
    
    func parseItemCSV() -> Dictionary<String, Item> {
        var items = Dictionary<String, Item>()
        let path = Bundle.main.path(forResource: "items", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let name = row["name"]!
                let isRetired = Bool.init(row["isRetired"]!.lowercased())!
                let item = Item(name: name, isRetired: isRetired)
                
                items[name] = item
                
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return items
    }
    
    func parseRelicCSV() -> Dictionary<Relic.Key, Relic> {
        var relics = Dictionary<Relic.Key, Relic>()
        let path = Bundle.main.path(forResource: "items", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let tier = Tier(rawValue: row["tier"]!)
                let type = row["type"]!
                let key = Relic.Key(tier: tier, name: type)
                let isRetired = Bool.init(row["isRetired"]!.lowercased())!
                let relic = Relic(key: key, isRetired: isRetired)
                
                relics[key] = relic
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return relics
    }
    
    func parseRewardCSV(relics: Dictionary<Relic.Key, Relic>, items: Dictionary<String, Item>) -> [Reward] {
        var rewards = [Reward]()
        let path = Bundle.main.path(forResource: "items", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let itemName = row["item"]!.capitalized
                let tier = Tier(rawValue: row["tier"]!.capitalized)
                let type = row["type"]!
                let key = Relic.Key(tier: tier, name: type)
                let rarity = Rarity(rawValue: row["rarity"]!.capitalized)
                
                let reward = Reward(relic: relics[key]!, item: items[itemName]!, rarity: rarity!)
                
                rewards.append(reward)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return rewards
    }
}
