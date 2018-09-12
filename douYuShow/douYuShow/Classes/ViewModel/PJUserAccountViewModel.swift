//
//  PJUserAccountViewModel.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/3.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
/*
 1.封装网络请求
 2.处理数据相关的逻辑
 3.数据缓存
 */


//private let userAccount_Path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")

class PJUserAccountViewModel: NSObject {
    
    //全局只有一个登录用户
    static let shared: PJUserAccountViewModel = PJUserAccountViewModel()
    
    //需要持有一个模型对象
    var account : PJUserAccount?
    
    /// 获取登录信息
    ///
    /// - Parameters:
    ///   - code: 登录时产生的 code 码
    ///   - finished: 回调方法
    func loadAccessToken(code: String, finished: @escaping (Bool) -> ()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let para = ["client_id" : client_id,
                    "client_secret" : client_secret,
                    "grant_type" : "authorization_code",
                    "code" : code,
                    "redirect_uri" : redirect_uri]
        
        PJNetworkTools.shared.request(method: .POST, urlString: urlString, parameters: para) { (res, error) in
            if error != nil {
//                SVProgressHUD.showError(withStatus: "世界上最遥远的距离就是没有网络")
                //执行失败的回调
                finished(false)
                return
            }
            //调用方法 获取用户信息
            self.loadUserInfo(res as! [String : Any],loadUserInfoFinished: finished)
            //执行成功的回调
            finished(true)
        }
    }
    
    /// 获取用户信息
    ///
    /// - Parameters:
    ///   - dict: 登录获取到的参数
    ///   - loadUserInfoFinished: 回调方法
    func loadUserInfo (_ dict: [String: Any],loadUserInfoFinished:@escaping(Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        let token = dict["access_token"]
        let uid = dict["uid"]!
        
        let para = ["access_token": token,
                    "uid": uid];
        PJNetworkTools.shared.request(method: .GET, urlString: urlString, parameters: para) { (res, error) in
            if error != nil {
//                SVProgressHUD.showError(withStatus: "世界上最遥远的距离就是没有网络")
                loadUserInfoFinished(false)
                return
            }
            var userInfoDict = res as! [String : Any]
            //将登录后生成的 dict 与 userInfoDict 合并
            for(key,value) in dict{
                userInfoDict[key] = value
            }
            
            //通过 字典 生成模型
            let userAccount = PJUserAccount(dict: userInfoDict)
            
            //归档到沙盒
            //1.路径
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")
            //2.归档
            NSKeyedArchiver.archiveRootObject(userAccount, toFile: path)
            //执行成功的回调
            loadUserInfoFinished(true)
        }
    }
    
    
    
    
}
