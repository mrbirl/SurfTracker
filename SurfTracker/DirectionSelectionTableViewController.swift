//
//  DirectionSelectionTableViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 18/10/2018.
//  Copyright © 2018 Cian Brassil. All rights reserved.
//

import UIKit

class DirectionSelectionTableViewController: UITableViewController {
    
    var compassPoints: [String] = []
    var selectedPoint = Int()
    var directionDestination = "" // What this direction will be used for (wind or swell)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compassPoints = Helper.getCompassPoints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compassPoints.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectionSelectionCell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = compassPoints[row]
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "directionToSession"{
            selectedPoint = (tableView.indexPathForSelectedRow?.row)!
        }
        
    }
    
}
