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

class Windguru: NSObject {

    
    func loadJson() {
        if let path = Bundle.main.path(forResource: "windguru_spots", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    var jsonDict = jsonObj["Europe"]["Ireland"]["Lahinch"]
                    print(jsonDict)
                    
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }

    
    // MARK: Region
    var region:[String] = [
        "Australasia",
        "Europe"
    ]
    
    // MARK: Area
    var areaList:[String:String] = [
        "New South Wales":"Australasia",
        "New Zealand":"Australasia",
        "Ireland":"Europe",
        "France":"Europe"
    ]
    
    //Linear search for all areas in a given region
    func areas(region:String) -> [String]{
        var shortList:[String] = []
        for area in Array(areaList.keys){
            if areaList[area] == region{
                shortList += [area]
            }
        }
        return shortList
    }
    
    // MARK: Spot
    var spotList:[String:String] = [
        "Manly":"New South Wales",
        "Bondi":"New South Wales",
        "90 Mile Beach":"New Zealand",
        "Raglan":"New Zealand",
        "Lahinch":"Ireland",
        "Hossegor":"France",
        "Capbreton":"France"
    ]
    
    func spots(area:String) -> [String]{
        var shortList:[String] = []
        for spot in Array(spotList.keys){
            if spotList[spot] == area{
                shortList += [spot]
            }
        }
        return shortList
    }
    
    // MARK: Spot Info
    var infoList:[String:String] = [
        "Manly":"/Sydney-Manly-Surf-Report/526/",
        "Bondi":"/Sydney-Bondi-Surf-Report/996/",
        "90 Mile Beach":"/90-Mile-Beach-Surf-Report/118/",
        "Raglan":"/Raglan-Surf-Report/91/",
        "Lahinch":"/Lahinch-Beach-Surf-Report/52/",
        "Bundoran":"/Bundoran-The-Peak-Surf-Report/50/",
        "Hossegor":"/Hossegor-La-Graviere-Surf-Report/61/",
        "Capbreton":"/Capbreton-La-Piste-VVF-Surf-Report/883/"
    ]
    
    // Get URL for a spot
    func info(spot:String) -> String {
        return infoList[spot]!
    }

}
