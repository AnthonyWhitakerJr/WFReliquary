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
    
    static func parsePrimePartCsv(into context: NSManagedObjectContext) -> Dictionary<String, PrimePart> {
        var primeParts = Dictionary<String, PrimePart>()
        let path = Bundle.main.path(forResource: "PrimeParts", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let name = row["name"]!
                let isVaulted = Bool.init(row["isVaulted"]!.lowercased())!
                let imageName = row["imageName"]!
                let ducatValue = Int16(row["ducatValue"]!)!
                let part = PrimePart(name: name, isVaulted: isVaulted, imageName: imageName, ducatValue: ducatValue, insertInto: context)
                
                primeParts[name] = part
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return primeParts
    }
    
    static func parsePrimeSetCsv(into context: NSManagedObjectContext) -> Dictionary<String, PrimeSet> {
        var primeSets = Dictionary<String, PrimeSet>()
        let path = Bundle.main.path(forResource: "PrimeSet", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let name = row["name"]!
                let imageName = row["imageName"]!
                let primeSet = PrimeSet(name: name, imageName: imageName, insertInto: context)
                
                primeSets[name] = primeSet
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return primeSets
    }
    
    static func parsePrimeSetComponentsCsv(primeSets: Dictionary<String, PrimeSet>, primeParts: Dictionary<String, PrimePart>, into context: NSManagedObjectContext) {
        let path = Bundle.main.path(forResource: "PrimeSetComponents", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let partName = row["partName"]!
                let setName = row["setName"]!
                let numberRequired = Int16(row["numberRequired"]!)
                let primeSet = primeSets[setName]!
                let primePart = primeParts[partName]!
                _ = PrimeSetComponent(primeSet: primeSet, primePart: primePart, numberRequired: numberRequired!, insertInto: context)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    static func parseRelicCsv(into context: NSManagedObjectContext) -> Dictionary<Relic.Key, Relic> {
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
                let relic = Relic(key: key, isVaulted: isVaulted, insertInto: context)
                
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
                
                let reward = Reward(relic: relic, primePart: part, rarity: rarity!, insertInto: context)
                
                rewards.append(reward)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        return rewards
    }
    
    static func parseDropChanceCsv(into context: NSManagedObjectContext) {
        let path = Bundle.main.path(forResource: "DropChances", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let quality = Quality(string: row["Quality"]!)
                let common = Double(row["Common"]!)
                let uncommon = Double(row["Uncommon"]!)
                let rare = Double(row["Rare"]!)
                
                _ = DropChance(quality: quality!, rarity: .Common, chance: common!, into: context)
                _ = DropChance(quality: quality!, rarity: .Uncommon, chance: uncommon!, into: context)
                _ = DropChance(quality: quality!, rarity: .Rare, chance: rare!, into: context)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    static func parseMyCollection(primeParts: Dictionary<String, PrimePart>, into context: NSManagedObjectContext) {
        let path = Bundle.main.path(forResource: "MyCollection", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfFile: path!)
            let rows = csv.rows
            
            for row in rows {//Force upwrap to fail fast
                let name = row["name"]!
                let count = Int32(row["count"]!)

                
                let part = primeParts[name]!
                part.count = count!
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

}
