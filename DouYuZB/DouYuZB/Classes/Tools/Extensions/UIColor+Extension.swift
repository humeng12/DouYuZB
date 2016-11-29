//
//  UIColor+Extension.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/11/29.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        
        self.init(red: r / 255.0,green: g / 255.0, blue: b / 255.0,alpha:1.0)
    }
}
