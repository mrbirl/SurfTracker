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
    
    var time: NSDate
    var photo: UIImage?
    var rating: Int
    var tide: String?
    
    // MARK: Initialization
    
    init(time: NSDate, photo: UIImage?, rating: Int, tide: String?) {
        self.time = time
        self.photo = photo
        self.rating = rating
        self.tide = tide
        
        //TODO
        // Initialization should fail if there is no time or if the rating is negative.
//        if time == nil || rating < 0 {
//            return nil
//        }
    }
    
}
