//
//  ViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 10/08/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var sessionDateTextField: UITextField!
    
    @IBOutlet weak var tideTextField: UITextField!
    
    var tidePickOption = [["Low", "Mid", "High"], ["Rising", "Falling"]]
    
    var default_tide: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.ß
        
        // Set default tide (for 'cancel' button when selecting tide)
        default_tide = ""
        
        // Set the default time for the session
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = .ShortStyle
        sessionDateTextField.text = (dateFormatter.stringFromDate(NSDate()))
        
        // Datepicker for session date/time
        
        let dateToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        dateToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        dateToolBar.barStyle = UIBarStyle.BlackTranslucent
        
        dateToolBar.tintColor = UIColor.whiteColor()
        
        dateToolBar.backgroundColor = UIColor.blackColor()
        
        
        let dateNowBtn = UIBarButtonItem(title: "Now", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.tappedNowDateToolBarBtn))
        
        let dateOkBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(ViewController.dateDonePressed))
        
        let dateFlexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        dateLabel.font = UIFont(name: "Helvetica", size: 12)
        
        dateLabel.backgroundColor = UIColor.clearColor()
        
        dateLabel.textColor = UIColor.whiteColor()
        
        dateLabel.text = "Set Session Time"
        
        dateLabel.textAlignment = NSTextAlignment.Center
        
        let dateTextBtn = UIBarButtonItem(customView: dateLabel)
        
        dateToolBar.setItems([dateNowBtn,dateFlexSpace,dateTextBtn,dateFlexSpace,dateOkBarBtn], animated: true)
        
        sessionDateTextField.inputAccessoryView = dateToolBar
        
        // Picker for Tide
        
        let tidePickerView = UIPickerView()
        
        tidePickerView.delegate = self
        
        tideTextField.inputView = tidePickerView
        
        let tideToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        tideToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        tideToolBar.barStyle = UIBarStyle.BlackTranslucent
        
        tideToolBar.tintColor = UIColor.whiteColor()
        
        tideToolBar.backgroundColor = UIColor.blackColor()
        
        
        let tideCancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.tappedTideCancelToolBarBtn))
        
        let tideDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(ViewController.tideDonePressed))
        
        let tideFlexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let tideLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        tideLabel.font = UIFont(name: "Helvetica", size: 12)
        
        tideLabel.backgroundColor = UIColor.clearColor()
        
        tideLabel.textColor = UIColor.whiteColor()
        
        tideLabel.text = "Set Tide Stage"
        
        tideLabel.textAlignment = NSTextAlignment.Center
        
        let tideTextBtn = UIBarButtonItem(customView: tideLabel)
        
        tideToolBar.setItems([tideCancelButton,tideFlexSpace,tideTextBtn,tideFlexSpace,tideDoneButton], animated: true)
        
        tideTextField.inputAccessoryView = tideToolBar
        
    }
    
    // MARK: Actions
    
    
    // Datepicker management
    
    @IBAction func sessionDateEditing(sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func dateDonePressed(sender: UIBarButtonItem) {
        
        sessionDateTextField.resignFirstResponder()
        
    }
    
    func tappedNowDateToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        dateformatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        sessionDateTextField.text = dateformatter.stringFromDate(NSDate())
        
        sessionDateTextField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        sessionDateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    // Tide picker management
    
    func tideDonePressed(sender: UIBarButtonItem) {
        default_tide = tideTextField.text  // Update current tide default, in case user cancels when editing again
        tideTextField.resignFirstResponder()
        
    }
    
    func tappedTideCancelToolBarBtn(sender: UIBarButtonItem) {
        
        tideTextField.text = default_tide
        
        tideTextField.resignFirstResponder()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return tidePickOption.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tidePickOption[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tidePickOption[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tide_height = tidePickOption[0][pickerView.selectedRowInComponent(0)]
        let tide_direction = tidePickOption[1][pickerView.selectedRowInComponent(1)]
        tideTextField.text = tide_height + " | " + tide_direction
    }
    


}

