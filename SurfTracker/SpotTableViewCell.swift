//
//  SpotTableViewCell.swift
//  SurfTracker
//
//  Created by Cian Brassil on 31/01/2017.
//  Copyright © 2017 Cian Brassil. All rights reserved.
//

import UIKit

class SpotTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var spotLabel: UILabel!
    @IBOutlet weak var spotPhotoImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
