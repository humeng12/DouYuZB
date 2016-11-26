//
//  UIBarButtonItem+Extension.swift
//  DouYuZB
//
//  Created by 胡猛 on 16/11/6.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    class func createItem(_ imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem{
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
    
    convenience init(imageName: String,highImageName: String = "",size: CGSize = CGSize.zero) {
      
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView:btn)
    }
}
