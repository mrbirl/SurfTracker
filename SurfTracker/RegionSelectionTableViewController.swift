//
//  RegionSelectionTableViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 19/6/17.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit

class RegionSelectionTableViewController: UITableViewController {
    
    var forecasts: Forecasts?
    var regions: [String] = []
    var selectedForecast = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        forecasts = Forecasts(forecast: selectedForecast)
        let unsortedRegions = (forecasts?.getRegions())!
        regions = unsortedRegions.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return regions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionSelectionCell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = regions[row]

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


    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AreaSelections"{
            let target = segue.destination as! AreaSelectionTableViewController
            let selectedRegion = regions[(tableView.indexPathForSelectedRow?.row)!]
            target.region = selectedRegion
            let unsortedAreas = (forecasts?.getAreas(region: selectedRegion))!
            // Now sort areas alphabetically so it's a nicer menu :)
            target.areas = unsortedAreas.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            target.navigationItem.title = selectedRegion
            target.forecasts = forecasts
        }
    }
 

}
