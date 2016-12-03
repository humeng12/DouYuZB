//
//  CustomNavitationController.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/3.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class CustomNavitationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let systemGes = interactivePopGestureRecognizer else {return}
        
        guard let gesView = systemGes.view else {return}
        
        /*
        var count : UInt32 = 0
        let ivars =  class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0..<count {
            
            let ivar = ivars?[Int(i)]
            
            let name = ivar_getName(ivar)
        }*/
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        
        
        guard let target = targetObjc.value(forKey: "target") else {return}
        //guard let action = targetObjc.value(forKey: "action") as? Selector else {return}
        let action = Selector(("handleNavigationTransition:"))
        
        
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
