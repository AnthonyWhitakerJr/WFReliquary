//
//  FirstViewController.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/11/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import CoreData

class FissureViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var relicTierControl: UISegmentedControl!
    @IBOutlet weak var relicCollectionView: UICollectionView!
    @IBOutlet weak var selectedRelicCollectionView: UICollectionView!
    
    var relicsAll = Dictionary<Relic.Key, Relic>()
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
        
        populateRelics()
        relicsByTier = RelicUtils.groupByTier(relics: relicsAll)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Populates relicsAll property. Attempts to retrieve relics from database; otherwise parses them from csv and saves them to database.
    func populateRelics() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Relic> = Relic.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            self.relicsAll = results.toDictionary{ $0.key }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        if relicsAll.isEmpty {
            parseCsv(into: context)
        }
    }
    
    func parseCsv(into context: NSManagedObjectContext) {
        relicsAll = CsvReader.parseRelicCsv(into: context)
        
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
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

