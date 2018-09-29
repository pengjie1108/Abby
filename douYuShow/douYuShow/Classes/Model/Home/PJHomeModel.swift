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
    var created_at: Date?
    /// 微博 ID
    var id: Int64 = 0
    /// 微博内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 用户信息
    var user: PJUserModel?
    /// 转发微博数据
    var retweeted_status:PJHomeModel?
    /// 配图数据
    var pic_urls: [PJPictureUrlsModel]?
    
    /// 返回容器中所需要存放的数据类型
    ///
    /// - Returns: 返回的数据格式
    class func modelContainerPropertyGenericClass() -> [String: Any]{
        return ["pic_urls": PJPictureUrlsModel.self]
    }
}
