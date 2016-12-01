//
//  GameViewModel.swift
//  DYZB
//
//  Created by 胡猛 on 2016/11/30.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadGameData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            // 1.获取数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
