//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by 胡猛 on 2016/12/2.
//  Copyright © 2016年 HuMeng. All rights reserved.
//

import UIKit

class BaseViewModel {

    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}


extension BaseViewModel {

    func loadAnchorData(isGroupData:Bool,URLString : String,parameters:[String : Any]?=nil,finishedCallBack : @escaping () -> ()){
    
        NetworkTools.requestData(.get, URLString: URLString,parameters: parameters) {(result) in
            
            guard let resultDict = result as? [String : Any] else {return}
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            
            if isGroupData {
                for dict in dataArray {
                    
                    self.anchorGroups.append(AnchorGroup(dict: dict as! [String : NSObject]))
                }
            } else {
                
                let group = AnchorGroup()
                
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                
                self.anchorGroups.append(group)
            }
            
            finishedCallBack()
        }
    }
}
