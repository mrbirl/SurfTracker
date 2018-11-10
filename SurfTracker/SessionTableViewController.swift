//
//  SessionTableViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 25/09/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit
import os.log
import RealmSwift

class SessionTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var spot: Spot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (spot?.name != nil){
            self.title = (spot?.name)! + " Sessions"
        }
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
        
        cell.timeLabel.text = Helper.timeToString(sessionTime: (session?.time)!)
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
                Helper.realmAdd(item: session, update: true)
                self.tableView.reloadData()
            }
            else{
                // No selected row in the table view, so user tapped the Add button to get to the session detail scene.
                let newIndexPath = IndexPath(row: (spot?.sessions.count)!, section: 0)
                Helper.realmAdd(item: session)
                Helper.realmAddSessionToSpot(spot: spot!, session: session)
                self.tableView.reloadData()
            }
            // Update spot average rating (in case ratings changed in session) and tell spot table to update itself
            Helper.realmUpdateSpotRating(spot: spot!)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SessionSaved"), object: nil)
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender) // call to the superclass’s implementation
        
        switch(segue.identifier ?? "") { // If identifier is nil, nil-coalescing operator (??) replaces it empty string
            case "AddSession":
                print("Adding a new session.")
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
                // Hide the cancel button because we're showing, not creating
                sessionDetailViewController.navigationItem.setLeftBarButton(nil, animated: true)
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            }

    }
 

}
