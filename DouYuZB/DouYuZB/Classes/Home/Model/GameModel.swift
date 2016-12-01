//
//  GameModel.swift
//  DYZB
//
//  Created by 胡猛 on 2016/11/30.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class GameModel: GameBaseModel {
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
