//
//  GameViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/1.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2*kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5

private let kHeaderViewH : CGFloat = 50

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: UIViewController {
    
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let topHeaderView = CollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -(kGameViewH + kHeaderViewH), width: kScreenW, height: kHeaderViewH)
        topHeaderView.moreBtn.isHidden = true
        topHeaderView.titleLabel.text = "常用"
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        return topHeaderView
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


extension GameViewController {

    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
        
        // 1.添加collectionView
        view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH + kHeaderViewH, left: 0, bottom: 0, right: 0)
        
        // 2.添加GameView
        collectionView.addSubview(gameView)
        collectionView.addSubview(topHeaderView)
    }
}


extension GameViewController {

    fileprivate func loadData() {
    
        gameVM.loadGameData {
            self.collectionView.reloadData()
            
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}


extension GameViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gameVM.games.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.gameModel = gameVM.games[indexPath.item]
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "全部"
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}

