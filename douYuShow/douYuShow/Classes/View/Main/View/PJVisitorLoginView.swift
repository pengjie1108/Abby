//
//  PJVisitorLoginView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/10.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJVisitorLoginView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        addSubview(circleView)
    }
    
    //圈圈
    private lazy var circleView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_smallicon"))
    //房子
    private lazy var largeHouse: UIImageView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_house"))
    //遮罩
    private lazy var coverView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_mask_smallicon"))
    //提示文字
    private lazy var tipLabel: UILabel = UILabel(title: "关注一些人,回到这里看看有什么惊喜哟", textColor: UIColor.darkGray, fontSize: 14)
    //登录
    private lazy var loginBtn: UIButton = UIButton(title: "登录", textColor:  UIColor.darkGray, fontSize: 15, backImageName: "common_button_white")
    //注册
    private lazy var registerBtn: UIButton = UIButton(title: "注册", textColor:  UIColor.darkGray, fontSize: 15, backImageName: "common_button_white")

}
