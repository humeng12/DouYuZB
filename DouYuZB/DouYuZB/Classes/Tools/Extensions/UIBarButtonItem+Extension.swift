//
//  UIBarButtonItem+Extension.swift
//  DouYuZB
//
//  Created by 胡猛 on 16/11/6.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    //加class扩展类方法
    class func createItem(_ imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem{
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
    //便利构造函数 1 convenience开头 2 在构造函数中必须明确调用一个设计的构造函数(self调用)
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
