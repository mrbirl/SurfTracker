//
//  Session.swift
//  SurfTracker
//
//  Created by Cian Brassil on 24/09/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit
import RealmSwift

class Session: Object {
    dynamic var id = UUID().uuidString
    @objc dynamic var time = "" // No initialiser so defaulting to empty string for now
    @objc dynamic var rating = 0 // No initialiser so defaulting to 0 for now
    @objc dynamic var photoUrl: String?
    @objc dynamic var tide: String?
    var windSpeed = RealmOptional<Int>()
    var swellPeriod = RealmOptional<Int>()
    let spot = LinkingObjects(fromType: Spot.self, property: "sessions")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
