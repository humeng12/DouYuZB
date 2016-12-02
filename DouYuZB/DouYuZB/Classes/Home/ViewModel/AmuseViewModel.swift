//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/2.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{

}



extension AmuseViewModel {

    func loadAmuseData(finishedCallBack : @escaping () -> ()) {
        
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallBack);
    }
}
