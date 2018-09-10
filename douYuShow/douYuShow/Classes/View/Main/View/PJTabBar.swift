//
//  PJTabBar.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/10.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJTabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.bounds.size.width / 5
        let h = self.bounds.height
        //1.遍历 tabbar 所有子视图
        var index = 0
        for subView in subviews {
            //2.判断子视图类型是不是需要tabBarButton类型
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
                //3.对tabBarButton 类型做操作
                subView.frame = CGRect(x: w * CGFloat(index), y: 0, width: w, height: h)
                index += (index == 1 ? 2 : 1)
            }
        }
    }
}
