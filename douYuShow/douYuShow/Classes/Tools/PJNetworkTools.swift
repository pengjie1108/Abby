//
//  PJNetworkTools.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/11.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPMethod: Int {
    case GET = 0
    case POST
}

class PJNetworkTools: AFHTTPSessionManager {
    //单例对象
    static let shared: PJNetworkTools = {
       let tools = PJNetworkTools()
        //设置支持的解析数据的类型
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    //封装网络请求的核心方法
    func request(method: HTTPMethod,urlString: String,parameters: Any?,finished: @escaping (Any?, Error?) -> ()){
        //定义闭包对象
        let success = {
            (task: URLSessionDataTask,responseObjcet: Any?) -> () in
            //执行成功的回调
            finished(responseObjcet,nil)
        }
        
        let failure = {
            (task: URLSessionDataTask?, error: Error) -> () in
            //执行失败的回调
            print(error)
            finished(nil, error)
        }
        
        if method == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}

extension PJNetworkTools{
    func homeLoadData(since_id: Int64, max_id: Int64, finished: @escaping (Any?, Error?) -> ()){
        //URL
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //请求参数
        let params = ["access_token": PJUserAccountViewModel.shared.accessToken!,
                      "since_id":"\(since_id)",
                      "max_id":"\(max_id)"]
        //发送请求
        request(method: .GET, urlString: urlString, parameters: params, finished: finished)
    }
}
