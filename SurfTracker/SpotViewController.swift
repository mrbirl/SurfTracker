//
//  SpotViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 11/4/17.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit

class SpotViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var spotNameTextField: UITextField!
    @IBOutlet weak var spotPhotoImageView: UIImageView!
    @IBOutlet weak var windSpotName: UILabel!
    @IBOutlet weak var windSpotURL: UILabel!
    @IBOutlet weak var magicSpotName: UILabel!
    @IBOutlet weak var magicSpotURL: UILabel!
    
    var spot: Spot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Spot was passed in, so load data from this spot
        if let spot = spot {
            spotNameTextField.text = spot.name
            if spot.windguru != nil{
                windSpotName.text = spot.windguru?[0]
                windSpotURL.text = spot.windguru?[1]
            }
            if spot.msw != nil{
                magicSpotName.text = spot.msw?[0]
                magicSpotURL.text = spot.msw?[1]
            }
            
        }
        else{
            /*
             No existing spot data to prefill any fields
             Set any default values needed
             Create spot.
            */
            // Spot needs a name, if it's nil or empty string initialisation fails. This should probably be reworked.
            spot = Spot(name: "", sessions: nil, msw: nil, windguru: nil, photo: nil, notes: nil)
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
        spot?.name = spotNameTextField.text
        self.view.endEditing(true);
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let target = segue.destination as! RegionSelectionTableViewController
        target.spot = spot
        
        if segue.identifier == "WindguruSelections"{
            target.selectedForecast = "windguru"
        }
        if segue.identifier == "MagicseaweedSelections"{
            target.selectedForecast = "magicseaweed"
        }
    }
    

}
