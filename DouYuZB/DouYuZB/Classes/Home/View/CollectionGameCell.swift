//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 胡猛 on 2016/11/30.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性
    var gameModel : GameBaseModel? {
        didSet {
            titleLabel.text = gameModel?.tag_name
            if let iconURL = URL(string: gameModel?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL, placeholder:  UIImage(named: "home_more_btn"))
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
}
