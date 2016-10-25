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
    @IBOutlet weak var selectedRelicCollectionView: UICollectionView!
    
    var primeParts = Dictionary<String, PrimePart>()
    var relics = Dictionary<Relic.Key, Relic>()
    var rewards = [Reward]()
    var rewardsByRelic = Dictionary<Relic.Key, [Reward]>()
    var relicsByTier = Dictionary<Tier, [Relic]>()
    var selectedRelics = [Relic]()
    
    let maxRelicCount = 4
    
    var selectedTier: Tier? {
        let selectedTierTitle = relicTierControl.titleForSegment(at: relicTierControl.selectedSegmentIndex)
        if let selectedTier = selectedTierTitle?.capitalized {
            return Tier(string: selectedTier)
        }
        
        return nil
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        relicCollectionView.delegate = self
        relicCollectionView.dataSource = self
        
        selectedRelicCollectionView.delegate = self
        selectedRelicCollectionView.dataSource = self
        
        parseCsvFiles()
        rewardsByRelic = RewardUtils.groupByRelic(rewards: rewards)
        relicsByTier = RelicUtils.groupByTier(relics: relics)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseCsvFiles() {
        primeParts = CsvReader.parseItemCsv()
        relics = CsvReader.parseRelicCsv()
        rewards = CsvReader.parseRewardCsv(relics: relics, primeParts: primeParts)
    }
    
    // MARK: - Segmented Control
    @IBAction func tierChanged(_ sender: UISegmentedControl) {
        selectedRelics.removeAll()
        selectedRelicCollectionView.reloadData()
        relicCollectionView.reloadData()
    }
    
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == relicCollectionView {
            if let selectedTier = selectedTier {
                return relicsByTier[selectedTier]!.count
            }
        } else if collectionView == selectedRelicCollectionView {
            return selectedRelics.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == relicCollectionView {
            if let selectedTier = selectedTier {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelicCell", for: indexPath) as? FissureRelicCell {
                    let relic = relicsByTier[selectedTier]![indexPath.row]
                    cell.configureCell(relic: relic)
                    
                    return cell
                }
            }
        } else if collectionView == selectedRelicCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedRelicCell", for: indexPath) as? SelectedRelicCell {
                let relic = selectedRelics[indexPath.row]
                cell.configureCell(relic: relic)
                
                return cell
            }
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == relicCollectionView {
            let relicCell = collectionView.cellForItem(at: indexPath) as! FissureRelicCell
            
            if selectedRelics.count == maxRelicCount {
                removeAll(occurencesOf: relicCell.relic, from: &selectedRelics)
                relicCell.update(count: 0)
            } else {
                selectedRelics.append(relicCell.relic)
                selectedRelics.sort()
                
                let relicCount = relicCell.relicCount + 1
                relicCell.update(count: relicCount)
            }
        } else if collectionView == selectedRelicCollectionView {
            // Remove relic from selected relics
        }
        
        selectedRelicCollectionView.reloadData()
    }
    
    func removeAll(occurencesOf relic: Relic, from relics: inout [Relic]) {
        while let index = relics.index(of: relic) {
            relics.remove(at: index)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RewardsViewController" {
            if let rewardsVC = segue.destination as? RewardsViewController {
                rewardsVC.selectedRelics = selectedRelics
            }
        }
    }
    
}

