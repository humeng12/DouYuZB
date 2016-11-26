//
//  MainViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 16/11/6.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home");
        addChildVc("Live");
        addChildVc("Follow");
        addChildVc("My");
    }
    
    
    fileprivate func addChildVc(_ storyName:String){
    
        
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!;
        
        addChildViewController(childVc);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
