//
//  SpotViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 11/4/17.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit
import os.log

class SpotViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var spotNameTextField: UITextField!
    @IBOutlet weak var spotPhotoImageView: UIImageView!
    @IBOutlet weak var windSpotName: UILabel!
    @IBOutlet weak var windSpotURL: UILabel!
    @IBOutlet weak var magicSpotName: UILabel!
    @IBOutlet weak var magicSpotURL: UILabel!
    @IBOutlet weak var spotNotes: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var spot: Spot?
    var windguru = Windguru()
    var msw = Magicseaweed()
    var spotPhotoStringPath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Spot was passed in, so load data from this spot
        if let spot = spot {
            spotNameTextField.text = spot.name
            if spot.windguru != nil{
                windSpotName.text = spot.windguru?.name
                windSpotURL.text = spot.windguru?.url
            }
            if spot.msw != nil{
                magicSpotName.text = spot.msw?.name
                magicSpotURL.text = spot.msw?.url
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        spotPhotoImageView.image = selectedImage
        
        // Save the image
        spotPhotoStringPath = Helper.saveImage(image: selectedImage)
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func selectSpotImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func textField(_ sender: AnyObject) { // Spot name text field
        self.view.endEditing(true);
    }
    
    @IBAction func unwindToSpot(sender: UIStoryboardSegue) {
        // When a forecast is selected
        if let sourceViewController = sender.source as? SpotSelectionTableViewController {
            // Depending on what was being selected, set values
            switch sourceViewController.forecasts?.forecastName {
                case "windguru"?:
                    windguru.name = sourceViewController.selectedName
                    windguru.url = sourceViewController.selectedUrl
                    windSpotName.text = windguru.name
                    windSpotURL.text = windguru.url
                case "magicseaweed"?:
                    msw.name = sourceViewController.selectedName
                    msw.url = sourceViewController.selectedUrl
                    magicSpotName.text = msw.name
                    magicSpotURL.text = msw.url
                default:
                    print("Error: Invalid forecast case after forecast selection")
            }
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Dismisses this modal scene and animates the transition back to the previous scene (spot list)
        dismiss(animated: true, completion: nil)
    }
    

    // Do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        if let button = sender as? UIBarButtonItem, button === saveButton{
            // Saving spot
            let spotName = spotNameTextField.text ?? ""
            spot = Spot(value: ["name": spotName, "msw": msw, "windguru": windguru, "photoUrl": spotPhotoStringPath, "notes": spotNotes.text])
            Helper.realmAdd(item: spot!) // Force unwrapping because the spot is created right above
        } else {
            // Selecting forecast
            let target = segue.destination as! RegionSelectionTableViewController
            if segue.identifier == "WindguruSelections"{
                target.selectedForecast = "windguru"
            }
            if segue.identifier == "MagicseaweedSelections"{
                target.selectedForecast = "magicseaweed"
            }
        }
    }
    

}
