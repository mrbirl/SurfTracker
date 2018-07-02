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
    static func realmAdd(item: Object, update: Bool = false) {
        let realm = try! Realm()
        try! realm.write() {
            if(update == true){
                realm.add(item, update: true)
            }
            else{ // not updating, just adding a new one
                realm.add(item)
            }
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
    
    // Add session to spot
    static func realmAddSessionToSpot(spot: Spot, session: Session){
        let realm = try! Realm()
        try! realm.write {
            spot.sessions.append(session)
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
