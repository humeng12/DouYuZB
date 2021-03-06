//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/2.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit


let kItemMargin : CGFloat = 10
let kNomalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNomalItemW * 3 / 4
let kPrettyItemH = kNomalItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

let kGameViewH : CGFloat = 90


private let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: BaseViewController {
    
     var baseVM : BaseViewModel!
    
    
     lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNomalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



extension BaseAnchorViewController {
    
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
    }
}


extension BaseAnchorViewController {
    
    func loadData() {
    
    }
}


extension BaseAnchorViewController : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if baseVM == nil {
            return 1
        }
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if baseVM == nil {
            return 10
        }
        
        return baseVM.anchorGroups[section].anchors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kNormalCellID", for: indexPath) as! CollectionNormalCell
        
        if baseVM == nil {
            return cell
        }
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        if baseVM == nil {
            return headerView
        }
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}



extension BaseAnchorViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        anchor.isVertical == 0 ? pushNomalRoomVC() : presentShowRoomVC()
    }
    
    
    fileprivate func presentShowRoomVC() {
        
        let showRoomVC = RoomShowViewController()
        
        present(showRoomVC, animated: true, completion:nil)
    }
    
    
    fileprivate func pushNomalRoomVC() {
        
        let nomalRoomVC = RoomNomalViewController()
        navigationController?.pushViewController(nomalRoomVC, animated: true)
    }
}

