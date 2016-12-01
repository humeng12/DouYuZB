//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 16/11/6.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    //懒加载
    fileprivate lazy var pageTitleView:PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        
        return titleView;
    }()
    
    fileprivate lazy var pageContentView:PageContentView = {[weak self] in
        let contentH = kScreenH - kStatusBarH - kNavgationBarH - kTitleViewH - kTabbarH
        let cntentFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        for _ in 0..<2 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame:cntentFrame,childVcs:childVcs ,parentViewController:self)
        contentView.delegate = self as PageContentViewDelegate?
        
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置ui界面
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}


extension HomeViewController {
    
    fileprivate func setupUI() {
        
        //不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavgationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        
    }
    
    fileprivate func setupNavgationBar() {
    
        //设置导航栏左边图片
        //navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()//根据图片大小来设置按钮的frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        //设置右边3张图片
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.createItem("btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem.createItem("Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}



extension HomeViewController : PageTitleViewDelegate{

    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}


extension HomeViewController : PageContentViewDelegate {
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
