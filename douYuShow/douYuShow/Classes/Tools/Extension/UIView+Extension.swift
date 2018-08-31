//
//  UIView+Extension.swift
//  douYuShow
//
//  Created by jie peng on 2018/8/31.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

extension UIButton{
    convenience init(title: String, textColor:UIColor, fontSize:CGFloat,backImageName:String,imageName: String? = nil){
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.setBackgroundImage(UIImage(named: backImageName), for: .normal)
        if let img = imageName{
            self.setImage(UIImage(named: img), for: .normal)
        }
    }
}

