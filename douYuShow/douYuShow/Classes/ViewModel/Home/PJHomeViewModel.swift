//
//  PJHomeViewModel.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/13.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

/*
   -帮助微博首页请求数据
   -为微博首页保存数据和提供数据
 */
class PJHomeViewModel: NSObject {

    var dataArray:[PJStatusViewModel] = [PJStatusViewModel]()
    
}

//请求数据
extension PJHomeViewModel{
    func getHomeData(finish:@escaping (Bool) -> ()){
        PJNetworkTools.shared.homeLoadData { (response, error) in
            if error != nil{
                print("请求失败")
                finish(false)
                return
            }
            //解析 response
            //在 if let 或者 guard let 中 转类型的时候 一般情况 都需要使用的是 as
            guard let res = response as? [String: Any] else {
                return
            }
            //判断是否是 nil 而且是字典,获取字典中key 中数组数组
            guard let resArr = res["statuses"] as? [[String: Any]] else{
                return
            }
            //字典转模型
            let statusArray = NSArray.yy_modelArray(with: PJHomeModel.self, json: resArr) as! [PJHomeModel]
            //将模型数组每个元素放入 statusVM 属性中
            var tempArray:[PJStatusViewModel] = [PJStatusViewModel]()
            for homeModel in statusArray{
                let statuViewModel = PJStatusViewModel()
                statuViewModel.homeModel = homeModel
                tempArray.append(statuViewModel)
            }
            //赋值
            self.dataArray = tempArray
            //刷新
            finish(true)
        }
    }
}
