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
        self.time = time
        self.rating = rating
        self.photo = photo
        self.tide = tide
        
        // Initialization should fail if there is no time or if the rating is negative.
        if time.isEmpty || rating < 0 {
            return nil
        }
    }
}
