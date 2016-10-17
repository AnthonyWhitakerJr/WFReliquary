//
//  RewardViewController.swift
//  WarframeReliquary
//
//  Created by Anthony Whitaker on 10/17/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class RewardsViewController: UITableViewController {
    
    @IBOutlet weak var rewardsTableView: UITableView!
    
    var rewardsByRelic = Dictionary<Relic.Key, [Reward]>()
    var rewardsAll = [Reward]()
    var rewards = [Reward]()
    var relics = Dictionary<Relic.Key, Relic>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewardsTableView.delegate = self
        rewardsTableView.dataSource = self
        
        parseCsvFiles()
        rewardsByRelic = RewardUtils.groupByRelic(rewards: rewardsAll)
        
        var relicsFour = [Relic]()
        for (_, relic) in relics {
            relicsFour.append(relic)
            if relicsFour.count == 4 { break }
        }
        
        rewards = rewards(for: relicsFour)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func parseCsvFiles() {
        let items = CsvReader.parseItemCsv()
        relics = CsvReader.parseRelicCsv()
        rewardsAll = CsvReader.parseRewardCsv(relics: relics, items: items)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rewards(for relics: [Relic]) -> [Reward] {
        var rewardSet = Set<Reward>()
        for relic in relics {
            print("\(relic) - \(rewardsByRelic[relic.key]!)")
            for reward in rewardsByRelic[relic.key]! {
                rewardSet.insert(reward)
            }
        }
        return rewardSet.sorted()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rewards.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as? RewardTableViewCell {
            
            let reward = rewards[indexPath.row]
            cell.configureCell(reward: reward)
            
            return cell
        }
        
        return UITableViewCell()
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