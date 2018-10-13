//
//  Windguru.swift
//  SurfTracker
//
//  Created by Cian Brassil on 20/6/17.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

// Windguru Forecast Hierarchy Model

import UIKit
import SwiftyJSON

class Forecasts {
    
    var forecastName: String
    var json: JSON = [:]
    
    init(forecast: String){
        forecastName = forecast
        json = loadJson()
    }
    
    func loadJson() -> JSON {
        if let path = Bundle.main.path(forResource: forecastName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                return jsonObj
            } catch let error {
                print(error.localizedDescription)
                return JSON.null
            }
        } else {
            print("Invalid filename/path.")
            return JSON.null
        }
    }
    
    func getRegions() -> [String]{
        // Get a list of regions
        var regionList: [String] = []
        for (region,_):(String, JSON) in json {
            regionList.append(region)
        }
        return regionList
    }
    
    func getAreas(region: String) -> [String]{
        // Get a list of areas in a given region
        var areaList: [String] = []
        for (area,_):(String, JSON) in json[region] { // Iterate over keys in this regions dict
            areaList.append(area)
        }
        return areaList
    }
    
    func getSpots(region: String, area: String) -> [String]{
        // Get a list of spots, for an area
        var spotList: [String] = []
        for (spot,_):(String, JSON) in json[region][area] { // Iterate over keys in this regions dict
            spotList.append(spot)
        }
        return spotList
    }
    
    func getInfo(region: String, area: String, spot: String) -> String {
        return json[region][area][spot].string!
    }

}
