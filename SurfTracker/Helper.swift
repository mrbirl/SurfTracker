//
//  Helper.swift
//  SurfTracker
//
//  Created by Cian Brassil on 20/6/18.
//  Copyright © 2018 Cian Brassil. All rights reserved.
//

import UIKit

class Helper{
    
    // MARK: Documents Management
    
    // Getter for directory folder
    static func getDocumentsUrl() -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // Save image and return name
    static func saveImage(image: UIImage) -> String? {
        let fileName = "FileName"
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
