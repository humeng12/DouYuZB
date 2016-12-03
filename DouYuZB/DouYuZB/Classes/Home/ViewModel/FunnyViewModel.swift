//
//  FunnyViewModel.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/3.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    
    func loadFunnyDada(finishedCallBack : @escaping () -> ()){
    
        loadAnchorData(isGroupData: false,URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters:["limit" : 30,"offset" : 0] ,finishedCallBack: finishedCallBack)
    }
}
