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
    @objc dynamic var rating = 0 // No initialiser so defaulting to 0 for now
    @objc dynamic var time: Date?
    @objc dynamic var photoUrl: String?
    var tide = RealmOptional<Int>()
    var windSpeed = RealmOptional<Int>()
    var windDirection = RealmOptional<Int>()
    var swellDirection = RealmOptional<Int>()
    var swellPeriod = RealmOptional<Int>()
    var swellSize = RealmOptional<Double>()
    let spot = LinkingObjects(fromType: Spot.self, property: "sessions")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
