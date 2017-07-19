//
//  Spot.swift
//  SurfTracker
//
//  Created by Cian Brassil on 30/01/2017.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit

class Spot {
    
    // MARK: Properties
    
    var name: String?
    var sessions: [Session]
    var msw: [String]?
    var windguru: [String]?
    var photo: UIImage?
    var notes: String?
    
    //MARK: Initialization
    
    init?(name: String?, msw: [String]?, windguru: [String]?, photo: UIImage?, notes: String?) {
        
        self.sessions = []
        
        // Initialize stored properties
        if name != nil{
            self.name = name!
        }
        if msw != nil{
            self.msw = msw!
        }
        if windguru != nil{
            self.windguru = windguru!
        }
        self.photo = photo
        self.notes = notes
        
    }
    
}
