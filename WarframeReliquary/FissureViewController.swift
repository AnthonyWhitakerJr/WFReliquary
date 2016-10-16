//
//  FirstViewController.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class FissureViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var relicTierControl: UISegmentedControl!
    @IBOutlet weak var relicCollectionView: UICollectionView!
    
    var items = Dictionary<String, Item>()
    var relics = Dictionary<Relic.Key, Relic>()
    var rewards = [Reward]()
    var rewardsByRelic = Dictionary<Relic.Key, [Reward]>()
    var relicsByTier = Dictionary<Tier, [Relic]>()
    var selectedRelicCount = 0
    
    let maxRelicCount = 4
    
    var selectedTier: Tier? {
        let selectedTierTitle = relicTierControl.titleForSegment(at: relicTierControl.selectedSegmentIndex)
        if let selectedTier = selectedTierTitle?.capitalized {
            return Tier(rawValue: selectedTier)
        }
        
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        relicCollectionView.delegate = self
        relicCollectionView.dataSource = self
        
        parseCsvFiles()
        rewardsByRelic = RewardUtils.groupByRelic(rewards: rewards)
        relicsByTier = RelicUtils.groupByTier(relics: relics)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseCsvFiles() {
        items = CsvReader.parseItemCsv()
        relics = CsvReader.parseRelicCsv()
        rewards = CsvReader.parseRewardCsv(relics: relics, items: items)
    }
    // MARK: - Segmented Control
    @IBAction func tierChanged(_ sender: UISegmentedControl) {
        selectedRelicCount = 0
        relicCollectionView.reloadData()
    }
    
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let selectedTier = selectedTier {
            return relicsByTier[selectedTier]!.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let selectedTier = selectedTier {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelicCell", for: indexPath) as? FissureRelicCell {
                let relic = relicsByTier[selectedTier]![indexPath.row]
                cell.configureCell(relic: relic)
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let relicCell = collectionView.cellForItem(at: indexPath) as! FissureRelicCell

        if selectedRelicCount == maxRelicCount {
            selectedRelicCount = selectedRelicCount - relicCell.relicCount
            relicCell.update(count: 0)
        } else {
            selectedRelicCount = selectedRelicCount + 1
            let relicCount = relicCell.relicCount + 1
            relicCell.update(count: relicCount)
        }

    }
    
}

