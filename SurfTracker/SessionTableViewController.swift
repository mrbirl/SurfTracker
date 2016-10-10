//
//  SessionTableViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 25/09/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit

class SessionTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var sessions = [Session]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data.
        loadSampleSessions()
    }
    
    func loadSampleSessions(){
        
        var exampleTime: String
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = .short
        exampleTime = (dateFormatter.string(from: Date()))
        
        let photo1 = UIImage(named: "session1")!
        let session1 = Session(time: exampleTime, rating: 4, photo: photo1, tide: "High | Falling")!
        
        let photo2 = UIImage(named: "session2")!
        let session2 = Session(time: exampleTime, rating: 5, photo: photo2, tide: "Low | Rising")!
        
        let photo3 = UIImage(named: "session3")!
        let session3 = Session(time: exampleTime, rating: 3, photo: photo3, tide: nil)!
        
        sessions += [session1, session2, session3]
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
        return sessions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier. This creates a constant with the identifier which was set in the storyboard.
        let cellIdentifier = "SessionTableViewCell"

        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SessionTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let session = sessions[indexPath.row]
        
        cell.timeLabel.text = session.time
        cell.photoImageView.image = session.photo
        cell.ratingControl.rating = session.rating
        
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Selected row number \(indexPath.row)")
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
