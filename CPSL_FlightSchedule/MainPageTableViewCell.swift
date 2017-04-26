//
//  MainPageTableViewCell.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/13.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

@objc protocol MainPageTableViewCellDelegate {
    func tappedCell(with section: Int)
}

class MainPageTableViewCell: UITableViewCell {
    var row: Int? = nil
    var delegate: AnyObject? = nil
    
    @IBOutlet var images: UIImageView!
    @IBOutlet var label: UILabel!
    override func awakeFromNib() {
    super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
