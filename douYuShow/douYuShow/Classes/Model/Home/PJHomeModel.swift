//
//  PJHomeModel.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/13.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJHomeModel: NSObject {
    
    /// 创建时间
    var created_at: String?
    /// 微博 ID
    var id: Int = 0
    /// 微博内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 用户信息
    var user: PJUserModel?
    /// 转发微博数据
    var retweeted_status:PJHomeModel?
}
