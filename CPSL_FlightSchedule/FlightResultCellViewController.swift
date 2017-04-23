//
//  FlightResultCellViewController.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/19.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

class FlightResultCellViewController: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func layoutSubviews() {
        
        let testL = UILabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 40))
        
        testL.backgroundColor = UIColor.red
        
        self.addSubview(testL)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
