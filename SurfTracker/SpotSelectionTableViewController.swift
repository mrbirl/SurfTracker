//
//  SpotSelectionTableViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 19/6/17.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit

class SpotSelectionTableViewController: UITableViewController {
    
    let windguru = Windguru()
    var area = ""
    var spots = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        spots = windguru.spots(area: area)
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
        return spots.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotSelectionCell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = spots[row]
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ForecastDetails"{
            let target = segue.destination as! SpotViewController
            let selectedSpot = spots[(tableView.indexPathForSelectedRow?.row)!]
            target.spotName = selectedSpot
            let url = windguru.info(spot: selectedSpot)
            target.spotURL = url
        }
        
    }
    

}
