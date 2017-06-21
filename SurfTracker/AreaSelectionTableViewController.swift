//
//  AreaSelectionTableViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 19/6/17.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit

class AreaSelectionTableViewController: UITableViewController {
    
    let windguru = Windguru()
    var region = "Europe"
    var areas = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        areas = windguru.areas(region: region)
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
        return areas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaSelectionCell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = areas[row]
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SpotSelections"{
            let target = segue.destination as! SpotSelectionTableViewController
            let selectedArea = areas[(tableView.indexPathForSelectedRow?.row)!]
            target.area = selectedArea
            target.navigationItem.title = selectedArea
        }
    }
    

}
