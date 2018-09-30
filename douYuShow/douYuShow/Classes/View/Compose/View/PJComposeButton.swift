//
//  PJComposeButton.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/30.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJComposeButton: UIButton {
    
    override var isHidden: Bool{
        set{
            
        }
        get{
            return false
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = randomColor()
        //设置 imageView 的填充方式
        imageView?.contentMode = .center
        //设置 titleLabel 的属性
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: FONTSIZEOFNORMAL)
        setTitleColor(UIColor.darkGray, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置 imageView 和 titleLabel 的 frame
        imageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.width)
        titleLabel?.frame = CGRect(x: 0, y: self.frame.size.width, width: self.frame.size.width, height: self.frame.size.height - self.frame.size.width)
    }
}
