//
//  CSVReader.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import CoreData

class CsvReader {
    
    static func parseItemCsv(into context: NSManagedObjectContext) -> Dictionary<String, PrimePart> {
        var primeParts = Dictionary<String, PrimePart>()
        let path = Bundle.main.path(forResource: "Items", ofType: "csv")
        let entity = NSEntityDescription.entity(forEntityName: "PrimePart", in: context)!
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let name = row["name"]!
                let isVaulted = Bool.init(row["isVaulted"]!.lowercased())!
//                let part = NSEntityDescription.insertNewObject(forEntityName: "PrimePart", into: managedObjectContext) as! PrimePart //TODO: Delete me after testing
                let part = PrimePart(entity: entity, insertInto: context, name: name, isVaulted: isVaulted)
                
                primeParts[name] = part
                
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return primeParts
    }
    
    static func parseRelicCsv(into context: NSManagedObjectContext) -> Dictionary<Relic.Key, Relic> {
        var relics = Dictionary<Relic.Key, Relic>()
        let path = Bundle.main.path(forResource: "Relics", ofType: "csv")
        let entity = NSEntityDescription.entity(forEntityName: "Relic", in: context)!
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let tier = Tier(string: row["tier"]!)
                let type = row["type"]!
                let key = Relic.Key(tier: tier, name: type)
                let isVaulted = Bool.init(row["isVaulted"]!.lowercased())!
                let relic = Relic(entity: entity, insertInto: context, key: key, isVaulted: isVaulted)
                
                relics[key] = relic
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return relics
    }
    
    static func parseRewardCsv(relics: Dictionary<Relic.Key, Relic>, primeParts: Dictionary<String, PrimePart>, into context: NSManagedObjectContext) -> [Reward] {
        var rewards = [Reward]()
        let path = Bundle.main.path(forResource: "Rewards", ofType: "csv")
        let entity = NSEntityDescription.entity(forEntityName: "Reward", in: context)!
        
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
                
                let reward = Reward(entity: entity, insertInto: context, relic: relic, primePart: part, rarity: rarity!)
                
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
                let quality = Quality(string: row["Quality"]!)
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
