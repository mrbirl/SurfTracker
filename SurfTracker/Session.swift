//
//  Session.swift
//  SurfTracker
//
//  Created by Cian Brassil on 24/09/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit

class Session {
    
    // MARK: Properties
    
    var time: String
    var rating: Int
    var photo: UIImage?
    var tide: String?
    
    // MARK: Initialization
    
    init?(time: String, rating: Int, photo: UIImage?, tide: String?) {
        
        // The name must not be empty
        guard !time.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.time = time
        self.rating = rating
        self.photo = photo
        self.tide = tide
        
    }
}
