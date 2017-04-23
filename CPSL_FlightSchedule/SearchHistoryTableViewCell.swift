//
//  SearchHistoryTableViewCell.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/19.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {
    
    var label: UILabel? = nil
    
    override func layoutSubviews() {
        label = UILabel(frame: CGRect(x: 20.0, y: 0, width: 100.0, height: 20.0))
        drawTableViewCell()
    }
    
    private func drawTableViewCell() {
        contentView.addSubview(label!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
