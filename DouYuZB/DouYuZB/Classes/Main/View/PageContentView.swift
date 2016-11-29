//
//  PageContentView.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/11/29.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView:PageContentView,progress : CGFloat,sourceIndex : Int,targetIndex : Int)
    
}

fileprivate let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    fileprivate var childVcs:[UIViewController]
    fileprivate weak var parentViewController:UIViewController?
    
    fileprivate var startOffsetX : CGFloat = 0
    
    weak var delegate: PageContentViewDelegate?
    
    fileprivate var isForbidScrollDelegate : Bool = false
    
    
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
        
        //1 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        //2 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:ContentCellID )
        
        return collectionView
    }()

    init(frame: CGRect, childVcs: [UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageContentView {
    
    fileprivate func setupUI() {
    
        //1 将所有的子控制器添加父控制器中 
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2 添加UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}



extension PageContentView:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //先移除
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell;
    }
    
}


// UICollectionViewDelegate方法
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if isForbidScrollDelegate {return}
        //1 获取数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2 判断是左滑还是右滑
        let currentoffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentoffsetX > startOffsetX {
            //计算比例
            progress = currentoffsetX / scrollViewW - floor(currentoffsetX / scrollViewW)
            
            //计算sourceIndex
            sourceIndex = Int(currentoffsetX / scrollViewW)
            
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            if currentoffsetX - startOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
        } else {
            progress = 1 - (currentoffsetX / scrollViewW - floor(currentoffsetX / scrollViewW))
            
            targetIndex = Int(currentoffsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//对外暴露的方法 处理滚动
extension PageContentView {
    func setCurrentIndex(currentIndex :Int) {
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}

