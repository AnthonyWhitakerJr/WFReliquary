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
    var relicsByTier = Dictionary<Tier, [Relic]>() // TODO: Refactor to pull directly from context
    var selectedRelics = [SelectedRelic]()
    var selectedIndexPath: IndexPath? //FIXME: Find a better way of doing this

    
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
        
        selectedRelicCollectionView.layer.cornerRadius = 5.0
        selectedRelicCollectionView.layer.masksToBounds = true
        
        populateRelicsAll()
        relicsByTier = RelicUtils.groupByTier(relics: relicsAll)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        longPressGesture.minimumPressDuration = 0.18
        self.selectedRelicCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Populates relicsAll property. Attempts to retrieve relics from database.
    func populateRelicsAll() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Relic> = Relic.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            self.relicsAll = results.toDictionary{ $0.key }
        } catch let err as NSError {
            print(err.debugDescription)
        }

    }
    
    func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.selectedRelicCollectionView.indexPathForItem(at: gesture.location(in: self.selectedRelicCollectionView)) else {
                break
            }
            selectedRelicCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            self.selectedIndexPath = selectedIndexPath
        case UIGestureRecognizerState.changed:
            selectedRelicCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            selectedRelicCollectionView.endInteractiveMovement()

            if gesture.isOutsideView(){
                removeSelectedRelic()
            }
            
            selectedIndexPath = nil
        default:
            selectedRelicCollectionView.cancelInteractiveMovement()
            selectedIndexPath = nil
        }
    }
    
    func removeSelectedRelic() {
        guard !selectedRelics.isEmpty else {
            return
        }
        
        let removedRelic = selectedRelics.remove(at: self.selectedIndexPath!.row)
        selectedRelicCollectionView.reloadData()
        
        let row = indexPath(for: removedRelic.relic.key)
        let cell = relicCollectionView.cellForItem(at: IndexPath(row: row, section: 0)) as! FissureRelicCell
        cell.update(count: cell.relicCount - 1)
    }
    
    func indexPath(for key: Relic.Key) -> Array<Any>.Index {
        let relics = relicsByTier[selectedTier!]
        let index = relics!.index(where: {$0.key == key})
        return index!
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = selectedRelics.remove(at: sourceIndexPath.item)
        selectedRelics.insert(temp, at: destinationIndexPath.item)
    }
    
    // MARK: - Segmented Control
    @IBAction func tierChanged(_ sender: UISegmentedControl) {
        selectedRelicCollectionView.cancelInteractiveMovement()
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
                cell.configureCell(selectedRelic: relic)
                
                return cell
            }
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == relicCollectionView {
            let relicCell = collectionView.cellForItem(at: indexPath) as! FissureRelicCell
            
            if selectedRelics.count != maxRelicCount {
                selectedRelics.append(SelectedRelic(relic: relicCell.relic))
                
                let relicCount = relicCell.relicCount + 1
                relicCell.update(count: relicCount)
            }
        } else if collectionView == selectedRelicCollectionView {
            let relic = selectedRelics[indexPath.row]
            relic.cycleQuality()
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

