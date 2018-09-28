//
//  PJHomeViewModel.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/13.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import SDWebImage
/*
   -帮助微博首页请求数据
   -为微博首页保存数据和提供数据
 */
class PJHomeViewModel: NSObject {

    var dataArray:[PJStatusViewModel] = [PJStatusViewModel]()
    
}

//请求数据
extension PJHomeViewModel{
    func getHomeData(isPullUp:Bool ,finish:@escaping (Bool) -> ()){
        
        var sinceId: Int64 = 0
        var maxId: Int64 = 0
        //如果 isPullUp == true 代表上拉加载更多
        if isPullUp{
            //代表上拉加载更多
            maxId = dataArray.last?.homeModel?.id ?? 0
            if maxId > 0{
                maxId -= 1
            }
        }else{
            //表示下拉刷新
            sinceId = dataArray.first?.homeModel?.id ?? 0
        }
        
        PJNetworkTools.shared.homeLoadData(since_id: sinceId, max_id: maxId) { (response, error) in
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
             var tempArray:[PJStatusViewModel] = [PJStatusViewModel]()
            let statusArray = NSArray.yy_modelArray(with: PJHomeModel.self, json: resArr) as! [PJHomeModel]
            //将模型数组每个元素放入 statusVM 属性中
           
            for homeModel in statusArray{
                let statuViewModel = PJStatusViewModel()
                statuViewModel.homeModel = homeModel
                tempArray.append(statuViewModel)
            }
            self.downLoadSingeImage(tempArray: tempArray, finish: finish)
            //赋值
            //判断是否上拉加载过
            if isPullUp{
                self.dataArray = self.dataArray + tempArray
            }else{
                self.dataArray = tempArray + self.dataArray
            }
            
            self.dataArray = tempArray
            //刷新
            finish(true)
        }
    }
    
    private func downLoadSingeImage(tempArray:[PJStatusViewModel],finish:@escaping (Bool)->()){
        //创建调度组
        let group = DispatchGroup()
        //遍历 temparray 判断是否是一张图片
        for statusViewModel in tempArray{
            //判断原创微博是否是一张图片
            if statusViewModel.homeModel?.pic_urls?.count == 1{
                //使用调度组进行加标识
                group.enter()
                //使用 SD 完成图片下载
                SDWebImageDownloader.shared().downloadImage(with: URL(string: statusViewModel.homeModel?.pic_urls?.first?.thumbnail_pic ?? ""), options: [], progress: nil) { (image, data, error, _) in
//                    print("原创微博单张图片下载完成")
                    //取消调度组标识
                    group.leave()
                }
            }
            
            //判断转发微博是否是一张图片
            if statusViewModel.homeModel?.retweeted_status?.pic_urls?.count == 1{
                //使用调度组进行加标识
                group.enter()
                //使用 SD 完成图片下载
                SDWebImageDownloader.shared().downloadImage(with: URL(string: statusViewModel.homeModel?.pic_urls?.first?.thumbnail_pic ?? ""), options: [], progress: nil) { (image, data, error, _) in
//                    print("转发微博单张图片下载完成")
                    //取消调度组标识
                    group.leave()
                }
            }
        }
        //通过调度组通知 来监听单张图片是否下载完成
        group.notify(queue: DispatchQueue.main) {
//            print("-单张图片全部下载完成-")
            finish(true)
        }
    }
}
