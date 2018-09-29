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
    /// 微博来源字符串
    var sourceText: String?
    
    var homeModel: PJHomeModel?{
        didSet{
            mbrankImage = dealMbrankImage(mbrank: homeModel?.user?.mbrank ?? 0)
            verifiedImage = dealVerifiedImage(verified: homeModel?.user?.verified ?? 0)
            sourceText = dealSinaSourceText(source: homeModel?.source)
        }
    }
}

//MARK:处理微博来源业务逻辑
extension PJStatusViewModel{
    fileprivate func dealSinaSourceText(source: String?) -> String{
        //判断 source 是否为 nil, 而且当前字符包含>
        guard let s = source, s.contains("\">") else {
            return "来自遥远的地方"
        }
        //获取字符串的光标位置
        let startIndex = s.range(of: "\">")!
        let endIndex = s.range(of: "</")!
        //通过光标位置截取字符串
        let result = s.substring(with: startIndex.upperBound..<endIndex.lowerBound)
        //拼接返回
        return "来自" + result
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
