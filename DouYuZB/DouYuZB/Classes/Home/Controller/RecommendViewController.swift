//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/11/29.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kItemH = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

private let kNomalCellID = "kNomalCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNomalCellID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置ui界面
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension RecommendViewController {
    
    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
        
        
    }
}


extension RecommendViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12;
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 8;
        }
        return 4;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNomalCellID, for: indexPath)
        
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        return headerView
    }
}

