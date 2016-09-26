//
//  SessionTableViewCell.swift
//  SurfTracker
//
//  Created by Cian Brassil on 25/09/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
