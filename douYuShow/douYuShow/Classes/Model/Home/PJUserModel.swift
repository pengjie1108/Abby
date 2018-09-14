//
//  PJUserModel.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/14.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJUserModel: NSObject {
    
    /// 用户 id
    var id: Int = 0
    /// 名字
    var name: String?
    /// 头像地址
    var profile_image_url: String?
    /// 认证类型
    var verified: Int = 0
    /// 会员等级 1-6
    var mbrank: Int = 0
    
}
