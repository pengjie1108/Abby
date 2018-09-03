//
//  UIBarButtonItem+Extension.swift
//  douYuShow
//
//  Created by jie peng on 2018/8/31.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //给 UIBarButtonItem 扩充快速创建对象的方法
    //给函数的参数设置默认值,系统会是自动生成多个函数
    convenience init(title: String? = nil, backImage: String? = nil, imageName: String? = nil, target:Any?, action:Selector?){
        let btn = UIButton()
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitle(title, for: .normal)
        if let img = imageName {
            btn.setImage(UIImage(named: img), for: .normal)
            btn.setImage(UIImage(named: img + "_highlighted"), for: .highlighted)
        }
        if let t = target, let a = action {
            btn.addTarget(t, action: a, for: .touchUpInside)
        }
        btn.sizeToFit()
        
        //使用 self 调用指定的构造函数创建对象
        self.init()
        
        self.customView = btn
    }
}
