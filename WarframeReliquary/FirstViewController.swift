//
//  FirstViewController.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var items = Dictionary<String, Item>()
    var relics = Dictionary<Relic.Key, Relic>()
    var rewards = [Reward]()
    var rewardsTable = Dictionary<Relic.Key, [Reward]>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseCsvFiles()
        populateRelicRewardTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func parseCsvFiles() {
        items = CsvReader.parseItemCSV()
        relics = CsvReader.parseRelicCSV()
        rewards = CsvReader.parseRewardCSV(relics: relics, items: items)
    }
    
    func populateRelicRewardTable() {
        for reward in rewards {
            if rewardsTable[reward.relic.key] != nil {
                rewardsTable[reward.relic.key]!.append(reward)
            } else {
                rewardsTable[reward.relic.key] = [reward]
            }
        }
    }
}

