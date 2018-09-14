//
//  PJStatusViewModel.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/14.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

/*
 -view 级别的 viewModel
    -帮助 view 做数据处理的工具类
    ->数据->模型-> PJHomeModel
 */

class PJStatusViewModel: NSObject {
    
    /// 会员等级图片
    var mbrankImage: UIImage?
    /// 认证图片
    var verifiedImage: UIImage?
    
    var homeModel: PJHomeModel?{
        didSet{
            mbrankImage = dealMbrankImage(mbrank: homeModel?.user?.mbrank ?? 0)
            verifiedImage = dealVerifiedImage(verified: homeModel?.user?.verified ?? 0)
        }
    }
}

extension PJStatusViewModel{
    fileprivate func dealMbrankImage(mbrank: Int) -> UIImage?{
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return UIImage(named: "common_icon_membership")
    }
}

extension PJStatusViewModel{
    fileprivate func dealVerifiedImage(verified: Int) -> UIImage?{
        switch verified {
        case 1:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return UIImage(named: "avatar_vgirl")
        }
    }
}
