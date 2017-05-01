//
//  SearchHistoryTableViewCell.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/19.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var label: UILabel? = nil
    
    override func layoutSubviews() {
        label = UILabel(frame: CGRect(x: 20.0, y: 0, width: 300.0, height: 20.0))
        contentView.addSubview(label!)
   }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

