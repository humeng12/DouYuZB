//
//  RoomNomalViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/3.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class RoomNomalViewController: UIViewController ,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        //navigationController?.interactivePopGestureRecognizer?.delegate = self
        //navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
