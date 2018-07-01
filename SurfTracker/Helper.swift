//
//  Helper.swift
//  SurfTracker
//
//  Created by Cian Brassil on 20/6/18.
//  Copyright © 2018 Cian Brassil. All rights reserved.
//

import UIKit
import RealmSwift

class Helper{
    
    // MARK: Realm Management
    
    // Save something to Realm
    static func realmAdd(item: Object) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(item)
        }
    }
    
    // Get spot from Realm
    static func realmGetSpots() -> Results<Spot>{
        let realm = try! Realm()
        return realm.objects(Spot.self)
    }
    
    // Delete something from Realm
    static func realmDelete(item: Object){
        let realm = try! Realm()
        // Delete an object with a transaction
        try! realm.write {
            realm.delete(item)
        }
    }
    
    // Get sessions from Realm
//    static func realmGetSessions(spotId: String?) -> Results<Session>{
//        let realm = try! Realm()
//        if (spotId != nil){ // Get sessions for specific spot
//            return realm.objects(Session.self).filter("example = 'example'")
//        }
//        return realm.objects(Session.self) // Return all sessions for all spots
//    }
    
    // Add session to spot
    static func realmAddSessionToSpot(spot: Spot, session: Session){
        let realm = try! Realm()
        try! realm.write {
            spot.sessions.append(session)
        }
    }
    
    // Update sessions for a spot
    static func realmUpdateSessions(spot: Spot, newSessions: List<Session>){
        let realm = try! Realm()
        // Update an object with a transaction
        try! realm.write {
            spot.sessions = newSessions
        }
    }
    
    // MARK: Documents Management
    
    // Getter for directory folder
    static func getDocumentsUrl() -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // Save image and return name
    static func saveImage(image: UIImage) -> String? {
        let fileName = UUID().uuidString
        let fileURL = getDocumentsUrl().appendingPathComponent(fileName)
        if let imageData = UIImageJPEGRepresentation(image, 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }
    
    // Get UIImage given the name of the saved image
    static func loadImage(fileName: String) -> UIImage? {
        let fileURL = getDocumentsUrl().appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
}
