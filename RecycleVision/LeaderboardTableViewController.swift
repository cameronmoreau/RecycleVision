//
//  LeaderboardTableViewController.swift
//  RecycleVision
//
//  Created by Mary Huerta on 4/22/17.
//  Copyright © 2017 Mobi. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {
    
    @IBOutlet var points: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var rank: UILabel!
    
    var userNames = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        userNames.append("Harry")
        userNames.append("John")
        userNames.append("Luke")
        userNames.append("Larry")
        
        points.text = "336"
        rank.text = "1"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "userCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LeaderboardTableViewCell
        cell.Username.text = userNames[indexPath.row]
        cell.medal.image = cell.medal.image!.withRenderingMode(.alwaysTemplate)
        
        switch (indexPath.row){
        case 0:
            cell.medal.tintColor = UIColor(red: 0.97, green: 0.78, blue: 0.21, alpha: 1.0)
            cell.rank.text = ""
        case 1:
            cell.medal.tintColor = UIColor(red: 0.69, green: 0.67, blue: 0.64, alpha: 1.0)
            cell.rank.text = ""
        case 2:
            cell.medal.tintColor = UIColor.brown
            cell.rank.text = ""
        default:
            cell.medal.isHidden = true
            cell.rank.text = String(indexPath.row + 1)
        }
       
        return cell
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