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
    
    @IBOutlet weak var sessionDateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the default time for the session
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = .MediumStyle
        sessionDateButton.setTitle(dateFormatter.stringFromDate(NSDate()), forState: .Normal)
        
    }
    
    
    // MARK: Actions

    @IBAction func setSessionDate(sender: UIButton) {
        sessionDateButton.setTitle("August 18th, 2016", forState: .Normal)
    }
}

