//
//  UIView+Extension.swift
//  douYuShow
//
//  Created by jie peng on 2018/8/31.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

extension UILabel{
    convenience init(title: String, textColor: UIColor, fontSize: CGFloat ){
        self.init()
        //给label 设置基本的属性
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.numberOfLines = 0
        //自适应大小
        self.sizeToFit()
    }
}

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

