//
//  SessionTableViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 25/09/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit
import os.log

class SessionTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var spot: Spot?

    override func viewDidLoad() {
        super.viewDidLoad()
        if (spot?.name != nil){
            self.title = (spot?.name)! + " Sessions"
        }
        // Use the edit button item provided by the table view controller.
        // navigationItem.leftBarButtonItem = editButtonItem

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Right now there is just one section for all sessions. In future, sections grouping spots by date or similar might be a good idea, to make navigation easier.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If we had multiple sections above for months/years, we could potentially change this value to the number of sessions in a month/year
        return (spot?.sessions.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier. This creates a constant with the identifier which was set in the storyboard.
        let cellIdentifier = "SessionTableViewCell"

        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SessionTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let session = spot?.sessions[indexPath.row]
        
        cell.timeLabel.text = session?.time
        // cell.photoImageView.image = session?.photo
        cell.ratingControl.rating = (session?.rating)!
        if session?.photoUrl != nil{
            cell.photoImageView.image = Helper.loadImage(fileName: (session?.photoUrl!)!)
        }
        
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Selected row number \(indexPath.row)")
	}
    
    // MARK: Actions
    @IBAction func unwindToSessionList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? SessionViewController, let session = sourceViewController.session {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing session.
                spot?.sessions[selectedIndexPath.row] = session // Update session array replacing old session with updated one
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                /* No selected row in the table view, so user tapped the Add button to get to the session detail scene.
                 Add a new session. Computes the location in the table view where the new table view cell representing the new session will be inserted, and stores it in a local constant called newIndexPath. */
                let newIndexPath = IndexPath(row: (spot?.sessions.count)!, section: 0)
                
                spot?.sessions.append(session)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            spot?.sessions.remove(at: indexPath.row)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender) // call to the superclass’s implementation
        
        switch(segue.identifier ?? "") { // If identifier is nil, nil-coalescing operator (??) replaces it empty string
            case "AddSession":
                if #available(iOS 10.0, *) {
                    os_log("Adding a new session.", log: OSLog.default, type: .debug)
                } else {
                    // Fallback on earlier versions
            }
            case "ShowSession":
                guard let sessionDetailViewController = segue.destination as? SessionViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                guard let selectedSessionCell = sender as? SessionTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                guard let indexPath = tableView.indexPath(for: selectedSessionCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                let selectedSession = spot?.sessions[indexPath.row]
                sessionDetailViewController.session = selectedSession
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            }

    }
 

}
