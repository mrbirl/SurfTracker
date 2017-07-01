//
//  SpotSelectionTableViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 19/6/17.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit

class SpotSelectionTableViewController: UITableViewController {
    
    var windguru: Windguru?
    var region = String()
    var area = String()
    var spots = [String]()
    var spot: Spot?

    override func viewDidLoad() {
        super.viewDidLoad()
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
            let url = windguru?.getInfo(region: region, area: area, spot: selectedSpot)
            spot?.windguru = [selectedSpot, url!] // Don't appent, we want these to be only values in this array
            target.spot = spot
        }
        
    }
    

}
