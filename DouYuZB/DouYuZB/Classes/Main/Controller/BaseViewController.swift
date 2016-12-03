//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/3.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView : UIView?
    
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
    
        let imageView = UIImageView(image: UIImage(named:"loading-1" ))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named:"loading-1")!,UIImage(named:"loading-2")!,UIImage(named:"loading-3")!,UIImage(named:"loading-4")!]
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension BaseViewController {
    
    func setupUI() {
        
        contentView?.isHidden = true
        
        view.addSubview(animImageView)
        
        animImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    
    func loadDataFinished() {
        
        animImageView.stopAnimating()
        
        animImageView.isHidden = true
        
        contentView?.isHidden = false
    }
}
