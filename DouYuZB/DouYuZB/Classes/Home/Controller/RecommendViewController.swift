//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 胡猛 on 16/11/6.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit


private let kCycleViewH = kScreenW * 3 / 8


class RecommendViewController: BaseAnchorViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}


// MARK:- 设置UI界面内容
extension RecommendViewController {
    override func setupUI() {
        
        //1.
        super.setupUI()
        
        // 2.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3.将gameView添加collectionView中
        collectionView.addSubview(gameView)
        
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}


// MARK:- 请求数据
extension RecommendViewController {
    override func loadData() {
        
        baseVM = recommendVM
        
        // 1.请求推荐数据
        recommendVM.requestData {
            // 1.展示推荐数据
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            var tempGroups = self.recommendVM.anchorGroups
            tempGroups.removeFirst()
            tempGroups.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            tempGroups.append(moreGroup)
            self.gameView.groups = tempGroups
        }
        
        // 2.请求轮播数据
        recommendVM.requestCycleData { 
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}


extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            
            let group = recommendVM.anchorGroups[(indexPath as NSIndexPath).section]
            let anchor = group.anchors[(indexPath as NSIndexPath).item]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            cell.anchor = anchor
            
            return cell
            
        } else {
            
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if (indexPath as NSIndexPath).section == 1 {
                return CGSize(width: kNomalItemW, height: kPrettyItemH)
        }
            
        return CGSize(width: kNomalItemW, height: kNormalItemH)
    }
}


//// MARK:- 遵守UICollectionView的数据源协议
//extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return recommendVM.anchorGroups.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let group = recommendVM.anchorGroups[section]
//        
//        return group.anchors.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // 1.取出模型对象
//        let group = recommendVM.anchorGroups[(indexPath as NSIndexPath).section]
//        let anchor = group.anchors[(indexPath as NSIndexPath).item]
//        
//        // 2.定义Cell
//        var cell : CollectionBaseCell!
//        
//        // 3.取出Cell
//        if (indexPath as NSIndexPath).section == 1 {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
//        } else {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
//        }
//        
//        // 4.将模型赋值给Cell
//        cell.anchor = anchor
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        // 1.取出section的HeaderView
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
//        
//        // 2.取出模型
//        headerView.group = recommendVM.anchorGroups[(indexPath as NSIndexPath).section]
//        
//        return headerView
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if (indexPath as NSIndexPath).section == 1 {
//            return CGSize(width: kItemW, height: kPrettyItemH)
//        }
//        
//        return CGSize(width: kItemW, height: kNormalItemH)
//    }
//}
