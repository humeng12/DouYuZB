//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 胡猛 on 2016/11/30.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    
    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
