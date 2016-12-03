//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/2.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var amuseView : AmuseMenuView = {
        
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



extension AmuseViewController {

    override func setupUI() {
    
        super.setupUI()
        
        collectionView.addSubview(amuseView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}


extension AmuseViewController {
    
    override func loadData() {
        
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            
            self.collectionView.reloadData()
            
            var tempGroup = self.amuseVM.anchorGroups
            tempGroup.removeFirst()
            self.amuseView.groups = tempGroup
            
            self.loadDataFinished()
        }
    }
}

