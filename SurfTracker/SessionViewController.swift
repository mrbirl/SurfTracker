//
//  SessionViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 10/08/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit
import os.log

class SessionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var sessionDateTextField: UITextField!
    @IBOutlet weak var tideTextField: UITextField!
    @IBOutlet weak var sessionPhotoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `SessionTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new session.
     */
    var session: Session?
    var sessionPhotoUrl: String?
    
    var tidePickOption = [["Low", "Low/Mid", "Mid", "Mid/High", "High"], ["Rising", "Falling"]]
    
    var default_tide: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.ß
        
        // Set up views if editing an existing Session.
        if let session = session {
            sessionDateTextField.text = session.time
            tideTextField.text = session.tide
            ratingControl.rating = session.rating
            // Set default tide (for 'cancel' button when selecting tide)
            default_tide = session.tide
            // Load photo if there is one
            if session.photoUrl != nil{
                sessionPhotoImageView.image = Helper.loadImage(fileName: session.photoUrl!)
            }
        }
        else{
            
            default_tide = ""
            
            // Set the default time for the session
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.long
            dateFormatter.timeStyle = .short
            sessionDateTextField.text = (dateFormatter.string(from: Date()))
        }
        
        // Add date picker done buttons and styling for session time/date selection
        styleDatePicker()
        
        // Add tide picker for session tide
        addTidePicker()
        
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
    
    func addTidePicker(){
        // Picker for Tide
        let tidePickerView = UIPickerView()
        
        tidePickerView.delegate = self
        
        tideTextField.inputView = tidePickerView
        
        let tideToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        tideToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        tideToolBar.barStyle = UIBarStyle.blackTranslucent
        
        tideToolBar.tintColor = UIColor.white
        
        tideToolBar.backgroundColor = UIColor.black
        
        
        let tideCancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SessionViewController.tappedTideCancelToolBarBtn))
        
        let tideDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(SessionViewController.tideDonePressed))
        
        let tideFlexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let tideLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        tideLabel.font = UIFont(name: "Helvetica", size: 12)
        
        tideLabel.backgroundColor = UIColor.clear
        
        tideLabel.textColor = UIColor.white
        
        tideLabel.text = "Set Tide Stage"
        
        tideLabel.textAlignment = NSTextAlignment.center
        
        let tideTextBtn = UIBarButtonItem(customView: tideLabel)
        
        tideToolBar.setItems([tideCancelButton,tideFlexSpace,tideTextBtn,tideFlexSpace,tideDoneButton], animated: true)
        
        tideTextField.inputAccessoryView = tideToolBar

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
        /*
            It’s a good habit to always call super.prepare(for:sender:) whenever you override prepare(for:sender:).
            That way you won’t forget it when you subclass a different class.
         */
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            if #available(iOS 10.0, *) {
                os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            } else {
                // Fallback on earlier versions
            }
            
            return
        }
        
        let date = sessionDateTextField.text ?? ""
        let tide = tideTextField.text ?? ""
        let rating = ratingControl.rating
        
        // Set the session to be passed to SessionTableViewController after the unwind segue.
        session = Session(value: ["time": date, "rating": rating, "photoUrl": sessionPhotoUrl, "tide": tide])

    }
    
    
    // MARK: Actions
    
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
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateStyle = DateFormatter.Style.long
        
        dateformatter.timeStyle = DateFormatter.Style.short
        
        sessionDateTextField.text = dateformatter.string(from: Date())
        
        sessionDateTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.long
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        sessionDateTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    // Tide picker management
    
    func tideDonePressed(_ sender: UIBarButtonItem) {
        default_tide = tideTextField.text  // Update current tide default, in case user cancels when editing again
        tideTextField.resignFirstResponder()
        
    }
    
    func tappedTideCancelToolBarBtn(_ sender: UIBarButtonItem) {
        
        tideTextField.text = default_tide
        
        tideTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return tidePickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tidePickOption[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tidePickOption[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tide_height = tidePickOption[0][pickerView.selectedRow(inComponent: 0)]
        let tide_direction = tidePickOption[1][pickerView.selectedRow(inComponent: 1)]
        tideTextField.text = "Tide - " + tide_height + ", " + tide_direction
    }
    


}

