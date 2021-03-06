//
//  PJUserAccount.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/3.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJUserAccount: NSObject,NSCoding{
    
    // 授权唯一票据
    var access_token: String?
    
    // access_token的生命周期，单位是秒数。
    var expires_in: TimeInterval = 0{
        didSet {
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    // token 过期时间
    var expires_date: Date?
    
    // 授权用户 UID
    var uid: String?
    
    // 昵称
    var name: String?
    
    //用户头像地址(大图)
    var avatar_large: String?
    
    //初始化方法
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    //实现协议方法,归档
    func encode(with aCoder:NSCoder){
        //将属性对应的值存储起来
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }

    //解档
    required init(coder aDecoder:NSCoder) {
        //给属性赋值
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_date = aDecoder.decodeObject(forKey: "access_date") as? Date
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
}
