//
//  Windguru.swift
//  SurfTracker
//
//  Created by Cian Brassil on 20/6/17.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

// Windguru Forecast Hierarchy Model

import UIKit

class Windguru: NSObject {
    
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
        "Doolin":"Ireland",
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
    
    //linear search for all food with a given meal
    func info(spot:String) -> String {
        return infoList[spot]!
    }

}
