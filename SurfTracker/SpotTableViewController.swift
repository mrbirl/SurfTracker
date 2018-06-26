//
//  SpotTableViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 05/02/2017.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit
import os.log

class SpotTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var results = Helper.realmGetSpots()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loadSampleSpots()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SpotTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SpotTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SpotTableViewCell.")
        }
        
        // Fetches the appropriate spot for the data source layout.
        let spot = results[indexPath.row]
        
        cell.spotLabel.text = spot.name
        if spot.photoUrl != nil{
            cell.spotPhotoImageView.image = Helper.loadImage(fileName: spot.photoUrl!)
        }

        return cell
    }
    
    
    
    // MARK: Actions
    @IBAction func unwindToSpotList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? SpotViewController, let spot = sourceViewController.spot {
            let newIndexPath = IndexPath(row: results.count, section: 0)
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender) // call to the superclass’s implementation
        
        if segue.identifier == "ShowSessions"{
            guard let sessionTableViewController = segue.destination as? SessionTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedSpotCell = sender as? SpotTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedSpotCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedSpot = results[indexPath.row]
            sessionTableViewController.spot = selectedSpot
        }
    }
    

    // MARK: Private Methods
    
    private func loadSampleSpots(){
        
        print("Would load sample spots here")
        
        /*
        let photo1 = UIImage(named: "spot1")
        let photo2 = UIImage(named: "spot2")
        let photo3 = UIImage(named: "spot3")
        
        guard let spot1 = Spot(value: ["name": "Lahinch", "msw": nil, "windguru": nil, "photo": photo1, "notes": "This is sample spot, added as a demo."]) else {
            fatalError("Unable to instantiate spot1")
        }
        
        guard let spot2 = Spot(name: "Manly", msw: nil, windguru: nil, photo: photo2, notes: "This is sample spot, added as a demo.") else {
            fatalError("Unable to instantiate spot1")
        }
        
        guard let spot3 = Spot(name: "Curl Curl", msw: nil, windguru: nil, photo: photo3, notes: "This is sample spot, added as a demo.") else {
            fatalError("Unable to instantiate spot1")
        }
        
        spots += [spot1, spot2, spot3]
        */
    }

}
