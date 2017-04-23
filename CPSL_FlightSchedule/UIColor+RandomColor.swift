//
//  UIColor+RandomColor.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/12.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import Foundation
import UIKit

public let SCREEN_WIDTH = UIScreen.main.bounds.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.height

public let ThemeColor = UIColor(red: 129.0/256.0, green: 149.0/256.0, blue: 128.0/256.0, alpha: 1.0)

extension UIColor {
    static func randomColorWithRGB() -> UIColor{
        
        let redValue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        
        let greenValue = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        
        let blueValue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
    }
}
