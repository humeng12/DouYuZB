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
private let kNomalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kGameViewH : CGFloat = 90

private let kCycyleViewH : CGFloat = kScreenW * 3 / 8

private let kNomalCellID = "kNomalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyViewID = "kPrettyViewID"

class RecommendViewController: UIViewController {
    
    
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNomalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNomalCellID)
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNomalCellID)
        
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyViewID)
        
        return collectionView
    }()
    
    
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycyleViewH + kGameViewH), width: kScreenW, height: kCycyleViewH)
        return cycleView
    }()
    
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置ui界面
        setupUI()
        
        //发送网络请求
        loadData()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension RecommendViewController {
    
    fileprivate func loadData() {
        recommendVM.requestData{
            self.collectionView.reloadData()
            
            
            //将数据传递给GameView
            var tempGroups = self.recommendVM.anchorGroups
            tempGroups.removeFirst()
            tempGroups.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            tempGroups.append(moreGroup)
            self.gameView.groups = tempGroups
        }
        
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}


extension RecommendViewController {
    
    fileprivate func setupUI() {
        
        // 1.将UICollectionView添加到控制器的View中
        view.addSubview(collectionView)
        
        // 2.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3.将gameView添加collectionView中
        collectionView.addSubview(gameView)
        
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycyleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}


extension RecommendViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommendVM.anchorGroups.count;
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommendVM.anchorGroups[section]
        
        return group.anchors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if indexPath.section == 1 {
            
            return CGSize(width: kItemW, height: kPrettyItemH)
        } else {
            return CGSize(width: kItemW, height: kNomalItemH)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1.取出模型对象
        let group = recommendVM.anchorGroups[(indexPath as NSIndexPath).section]
        let anchor = group.anchors[(indexPath as NSIndexPath).item]
        
        // 2.定义Cell
        var cell : CollectionBaseCell!
        
        // 3.取出Cell
        if (indexPath as NSIndexPath).section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyViewID, for: indexPath) as! CollectionPrettyCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNomalCellID, for: indexPath) as! CollectionNormalCell
        }
        
        // 4.将模型赋值给Cell
        cell.anchor = anchor
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.取出模型
        headerView.group = recommendVM.anchorGroups[(indexPath as NSIndexPath).section]
        
        return headerView
    }
}

