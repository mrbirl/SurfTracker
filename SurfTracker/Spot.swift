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
    
    var name: String
    var sessions = [Session]()
    var msw = [String: String]()
    var windguru = [String]()
    var photo: UIImage?
    var notes: String?
    
    //MARK: Initialization
    
    init?(name: String, sessions: [Session]?, msw: [String: String]?, windguru: [String]?, photo: UIImage?, notes: String?) {
        
        // Initialization fails if there is no name.
        if name.isEmpty {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        if sessions != nil{
            self.sessions = sessions!
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
