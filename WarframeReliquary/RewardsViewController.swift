//
//  RewardViewController.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/17/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit
import CoreData

/// Set selectedRelics with relevant relics before loading this controller
class RewardsViewController: UITableViewController {
    
    @IBOutlet weak var rewardsTableView: UITableView!
    
    var rewardsByRarity = Dictionary<Rarity, [Reward]> ()
    var selectedRelics = [Relic]()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewardsTableView.delegate = self
        rewardsTableView.dataSource = self
        
        var rewardsForSelectedRelics = RewardUtils.rewards(for: selectedRelics)
        RewardUtils.setDropOdds(for: &rewardsForSelectedRelics)
        rewardsByRarity = RewardUtils.groupByRariry(rewards: rewardsForSelectedRelics)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel!.textColor = .white
        headerView.backgroundView?.backgroundColor = UIColor(red: 20/255.0, green: 39/255.0, blue: 47/255.0, alpha: 1)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return rewardsByRarity.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rarity = convertToRarity(from: section) {
            return rewardsByRarity[rarity]!.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as? RewardTableViewCell {
            if let rarity = convertToRarity(from: indexPath.section) {
                let reward = rewardsByRarity[rarity]![indexPath.row]
                cell.configureCell(reward: reward)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let rarity = convertToRarity(from: section) {
            return rarity.description
        }
        return ""
    }
    
    func convertToRarity(from section: Int) -> Rarity? {
        var rarity: Rarity?
        switch section {
        case 0:
            rarity = .Rare
        case 1:
            rarity = .Uncommon
        case 2:
            rarity = .Common
        default:
            rarity = nil
        }
        
        return rarity
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
