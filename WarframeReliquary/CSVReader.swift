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
    static let rewards = parseRewardCsv(relics: relics, primeParts: items)
    
    static func parseItemCsv() -> Dictionary<String, PrimePart> {
        var primeParts = Dictionary<String, PrimePart>()
        let path = Bundle.main.path(forResource: "Items", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let name = row["name"]!
                let isVaulted = Bool.init(row["isVaulted"]!.lowercased())!
                let part = PrimePart(name: name, isVaulted: isVaulted)
                
                primeParts[name] = part
                
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return primeParts
    }
    
    static func parseRelicCsv() -> Dictionary<Relic.Key, Relic> {
        var relics = Dictionary<Relic.Key, Relic>()
        let path = Bundle.main.path(forResource: "Relics", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let tier = Tier(string: row["tier"]!)
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
    
    static func parseRewardCsv(relics: Dictionary<Relic.Key, Relic>, primeParts: Dictionary<String, PrimePart>) -> [Reward] {
        var rewards = [Reward]()
        let path = Bundle.main.path(forResource: "Rewards", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let partName = row["item"]!.capitalized
                let tier = Tier(string: row["tier"]!.capitalized)
                let type = row["type"]!
                let key = Relic.Key(tier: tier, name: type)
                let rarity = Rarity(string: row["rarity"]!.capitalized)
                
                let relic = relics[key]!
                let part = primeParts[partName]!
                
                let reward = Reward(relic: relic, primePart: part, rarity: rarity!)
                
                rewards.append(reward)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return rewards
    }
    
    static func parseDropChanceCsv() -> Dictionary<Quality, DropChance> {
        var dropChances = Dictionary<Quality, DropChance>()
        let path = Bundle.main.path(forResource: "DropChances", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let quality = Quality(string: row["Quality"]!)
                let common = Double(row["Common"]!)
                let uncommon = Double(row["Uncommon"]!)
                let rare = Double(row["Rare"]!)
                let dropChance = DropChance(quality: quality!, common: common!, uncommon: uncommon!, rare: rare!)
                
                dropChances[quality!] = dropChance
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return dropChances
    }

}
