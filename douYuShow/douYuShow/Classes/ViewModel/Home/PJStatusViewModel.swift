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
    /// 微博事件字符串
    var createAtText: String?{
        return dealSinaTimeText(createAt: homeModel?.created_at)
    }
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

//MARK:处理微博时间业务逻辑
extension PJStatusViewModel{
    
    fileprivate func dealSinaTimeText(createAt: Date?) -> String?{
        guard let sinaDate = createAt else {
            return nil
        }
        //时间格式化
        let df = DateFormatter()
        //判断是否今年
        let isThisYear = dealSinaDateIsThisYear(sinaDate: sinaDate)
        //如果是今年
        if isThisYear {
            let calendar = Calendar.current
            //如果是今天
            if calendar.isDateInToday(sinaDate){
                let s = Int(Date().timeIntervalSince(sinaDate))
                if s <= 60{
                    return "刚刚"
                }else if s > 60 && s <= 60 * 60{
                    return "\(s/60)分钟前"
                }else{
                    return "\(s/3600)分钟前"
                }
            }else if calendar.isDateInYesterday(sinaDate){
                df.dateFormat = "昨天 hh:mm"
            }else{
                df.dateFormat = "MM月dd日 hh:mm"
            }
        }else{
            //如果不是今年
            df.dateFormat = "YYYY年MM月dd日 hh:mm"
        }
        let result = df.string(from: sinaDate)
        return result
    }
    
    fileprivate func dealSinaDateIsThisYear(sinaDate: Date) -> Bool{
        //时间格式化
        let df = DateFormatter()
        //指定日期格式
        df.dateFormat = "YYYY"
        //通过微博日期转微博日期字符串
        let sinaDateStr = df.string(from: sinaDate)
        //通过当前时间日期转当前日期字符串
        let currentDateStr = df.string(from: Date())
        //判断是否相等
        return sinaDateStr == currentDateStr
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
