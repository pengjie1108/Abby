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
    
    var mbrankImage: UIImage?
    
    var homeModel: PJHomeModel?{
        didSet{
            mbrankImage = dealMbrankImage(mbrank: homeModel?.user?.mbrank ?? 0)
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
