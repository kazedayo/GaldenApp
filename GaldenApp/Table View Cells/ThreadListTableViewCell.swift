//
//  ThreadListTableViewCell.swift
//  GaldenApp
//
//  Created by 1080 on 30/9/2017.
//  Copyright © 2017年 1080@galden. All rights reserved.
//

import UIKit
import Hero
import MarqueeLabel

class ThreadListTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    
    @IBOutlet weak var threadTitleLabel: MarqueeLabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
