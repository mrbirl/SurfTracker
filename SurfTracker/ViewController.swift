//
//  ViewController.swift
//  SurfTracker
//
//  Created by Cian Brassil on 10/08/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var sessionDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the default time for the session
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = .MediumStyle
        sessionDateTextField.text = (dateFormatter.stringFromDate(NSDate()))
        
        // Datepicker for session date/time
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.BlackTranslucent
        
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.backgroundColor = UIColor.blackColor()
        
        
        let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ViewController.tappedToolBarBtn))
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(ViewController.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.text = "Select a due date"
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        sessionDateTextField.inputAccessoryView = toolBar
        
    }
    
    // MARK: Actions
    
    
    // Datepicker management
    
    @IBAction func sessionDateEditing(sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func donePressed(sender: UIBarButtonItem) {
        
        sessionDateTextField.resignFirstResponder()
        
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        dateformatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        sessionDateTextField.text = dateformatter.stringFromDate(NSDate())
        
        sessionDateTextField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        sessionDateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }

}

