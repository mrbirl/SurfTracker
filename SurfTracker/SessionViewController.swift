//
//  SessionViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 10/08/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit
import os.log

class SessionViewController: UIViewController, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var sessionDateTextField: UITextField!
    @IBOutlet weak var sessionPhotoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var windSpeedTextField: UITextField!
    @IBOutlet weak var swellPeriodTextField: UITextField!
    @IBOutlet weak var swellSizeTextField: UITextField!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var swellDirectionLabel: UILabel!
    @IBOutlet weak var tideSegment: UISegmentedControl!
    
    /*
     This value is either passed by `SessionTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new session.
     */
    var session: Session?
    var sessionPhotoUrl: String?
    var windDirection: Int?
    var swellDirection: Int?
    var sessionTime: Date?
    var tide: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up views if editing an existing Session.
        if let session = session {
            self.title = Helper.timeToString(sessionTime: session.time!)
            ratingControl.rating = session.rating
            // Existing sessions always have a time - update the default values here
            sessionTime = session.time!
            self.title = Helper.timeToString(sessionTime: sessionTime!)
            // Load photo if there is one
            if session.photoUrl != nil{
                sessionPhotoImageView.image = Helper.loadImage(fileName: session.photoUrl!)
            }
            if session.windSpeed.value != nil{
                windSpeedTextField.text = String(session.windSpeed.value!)
            }
            if session.swellPeriod.value != nil{
                swellPeriodTextField.text = String(session.swellPeriod.value!)
            }
            if session.swellSize.value != nil{
                swellSizeTextField.text = String(session.swellSize.value!)
            }
            if session.windDirection.value != nil{
                windDirection = session.windDirection.value! // Need to also update the value as this is what gets saved
                windDirectionLabel.text = (Helper.getCompassPointFromInt(pointNum: session.windDirection.value!))
            }
            if session.swellDirection.value != nil{
                swellDirection = session.swellDirection.value! // Need to also update the value as this is what gets saved
                swellDirectionLabel.text = (Helper.getCompassPointFromInt(pointNum: session.swellDirection.value!))
            }
            if session.tide.value != nil{
                tide = session.tide.value!
                tideSegment.selectedSegmentIndex = tide!
            }
        }
        else{
            // Set the default time for the session
            sessionTime = Date()
            // Add date picker done buttons and styling for session time/date selection
            styleDatePicker()
            // Add the time to the text field, formatted
            sessionDateTextField.text = Helper.timeToString(sessionTime: sessionTime!)
        }
        
    }
    
    // MARK: Pickers
    
    func styleDatePicker(){
        
        let dateToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        dateToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        dateToolBar.barStyle = UIBarStyle.blackTranslucent
        dateToolBar.tintColor = UIColor.white
        dateToolBar.backgroundColor = UIColor.black
        let dateNowBtn = UIBarButtonItem(title: "Now", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SessionViewController.tappedNowDateToolBarBtn))
        let dateOkBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(SessionViewController.dateDonePressed))
        let dateFlexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        dateLabel.font = UIFont(name: "Helvetica", size: 12)
        dateLabel.backgroundColor = UIColor.clear
        dateLabel.textColor = UIColor.white
        dateLabel.text = "Set Session Time"
        dateLabel.textAlignment = NSTextAlignment.center
        let dateTextBtn = UIBarButtonItem(customView: dateLabel)
        dateToolBar.setItems([dateNowBtn,dateFlexSpace,dateTextBtn,dateFlexSpace,dateOkBarBtn], animated: true)
        sessionDateTextField.inputAccessoryView = dateToolBar
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
        sessionPhotoImageView.image = selectedImage
        // Save the image
        sessionPhotoUrl = Helper.saveImage(image: selectedImage)
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    @IBAction func unwindToSession(sender: UIStoryboardSegue) {
        // When a forecast is selected
        if let sourceViewController = sender.source as? DirectionSelectionTableViewController {
            switch sourceViewController.directionDestination{
            case "windDirection":
                windDirection = sourceViewController.selectedPoint
                windDirectionLabel.text = Helper.getCompassPointFromInt(pointNum: windDirection!)
            case "swellDirection":
                swellDirection = sourceViewController.selectedPoint
                swellDirectionLabel.text = Helper.getCompassPointFromInt(pointNum: swellDirection!)
            default:
                print("Error: Invalid direction selection case")
            }
            
            
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddSessionMode = presentingViewController is UINavigationController
        if isPresentingInAddSessionMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The SessionViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        if let button = sender as? UIBarButtonItem, button === saveButton{
            // Configure the destination view controller only when the save button is pressed.
            let rating = ratingControl.rating
            let windSpeed = Int(windSpeedTextField.text!) ?? nil
            let swellPeriod = Int(swellPeriodTextField.text!) ?? nil
            let swellSize = Double(swellSizeTextField.text!) ?? nil
            // Set the session to be passed to SessionTableViewController after the unwind segue.
            if(session != nil){
                // Updating an existing session. Create a new session with the same id as the old one, so Realm will use this to update the old one when written to Realm
                session = Session(value: ["id": session!.id, "time": sessionTime, "rating": rating, "photoUrl": sessionPhotoUrl, "tide": tide, "windSpeed": windSpeed, "swellPeriod": swellPeriod, "swellSize": swellSize, "windDirection": windDirection, "swellDirection": swellDirection])
            }
            else{
                // This is a new session, not an update. Create a session which can be saved and added to the spot from the table view
                session = Session(value: ["time": sessionTime, "rating": rating, "photoUrl": sessionPhotoUrl, "tide": tide, "windSpeed": windSpeed, "swellPeriod": swellPeriod, "swellSize": swellSize, "windDirection": windDirection, "swellDirection": swellDirection])
            }
        }
        else {
            // Selection compass direction
            let target = segue.destination as! DirectionSelectionTableViewController
            if segue.identifier == "WindDirectionSelection"{
                target.directionDestination = "windDirection"
            }
            if segue.identifier == "SwellDirectionSelection"{
                target.directionDestination = "swellDirection"
            }
        }

    }
    
    // MARK: Actions
    
    @IBAction func tideChanged(_ sender: Any) {
        switch tideSegment.selectedSegmentIndex
        {
        case 0:
            tide = 0
        case 1:
            tide = 1
        case 2:
            tide = 2
        default:
            break
        }
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    // Datepicker management
    
    @IBAction func sessionDateEditing(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        datePickerView.minuteInterval = 15
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(SessionViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func dateDonePressed(_ sender: UIBarButtonItem) {
        sessionDateTextField.resignFirstResponder()
    }
    
    func tappedNowDateToolBarBtn(_ sender: UIBarButtonItem) {
        sessionTime = Date() // Set session time to now
        sessionDateTextField.text = Helper.timeToString(sessionTime: sessionTime!)
        sessionDateTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        sessionTime = sender.date
        sessionDateTextField.text = Helper.timeToString(sessionTime: sessionTime!)
    }

}

