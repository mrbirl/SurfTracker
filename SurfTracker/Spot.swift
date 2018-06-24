//
//  Spot.swift
//  SurfTracker
//
//  Created by Cian Brassil on 30/01/2017.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit
import RealmSwift

class Spot: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var windguru: Windguru?
    @objc dynamic var msw: Magicseaweed?
    @objc dynamic var photoUrl: String?
    @objc dynamic var notes: String?
    var sessions = List<Session>()
}
