//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/3.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class FunnyViewController: BaseAnchorViewController {
    
    
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension FunnyViewController {

    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
}


extension FunnyViewController {
    
    override func loadData() {
        
        baseVM = funnyVM
        
        funnyVM.loadFunnyDada {
            
            self.collectionView.reloadData()
            
            self.loadDataFinished()
        }
    }
}
