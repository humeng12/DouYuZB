//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/11/30.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel{
    
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
}


extension RecommendViewModel {
    
    @available(iOS 9.0, *)
    func requestData(_ finishCallback :@escaping () ->()) {
        
        // 0.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        
        //创建Group
        let dGroup = DispatchGroup()
        
        //1.发送第一组数据请求
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) {(result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }

            dGroup.leave()
        }
        
        //2.发送第二组数据请求
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) {(result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        //3.发送第三组数据请求
        dGroup.enter()
//        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {(result) in
//        
//            // 1.将result转成字典类型
//            guard let resultDict = result as? [String : NSObject] else { return }
//            
//            // 2.根据data该key,获取数组
//            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
//            
//            // 3.遍历数组,获取字典,并且将字典转成模型对象
//            for dict in dataArray {
//                let group = AnchorGroup(dict: dict)
//                self.anchorGroups.append(group)
//            }
//            
//            dGroup.leave()
//        }
        
        loadAnchorData(isGroupData: true,URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
        
            dGroup.leave()
        }
        
        
        //所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
        
    }
    
    
    func requestCycleData(_ finishCallback :@escaping () ->()) {
        
        let parameters = ["version" : "2.300"]
        
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: parameters) {(result) in
            
            
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            
            finishCallback()
        }
    }
}
