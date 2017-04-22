//
//  LeaderboardTableViewCell.swift
//  RecycleVision
//
//  Created by Mary Huerta on 4/22/17.
//  Copyright © 2017 Mobi. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet var points: UILabel!
    @IBOutlet var Username: UILabel!
    @IBOutlet var Usericon: UIImageView!
    @IBOutlet var rank: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
