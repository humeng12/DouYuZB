//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/2.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit


class AmuseViewController: BaseAnchorViewController {
    
    
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension AmuseViewController {
    
    override func loadData() {
        
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            
            self.collectionView.reloadData()
        }
    }
}

