//
//  PJVisitorLoginView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/10.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import SnapKit

protocol PJVisitorLoginViewDelegate:NSObjectProtocol {
    //定义协议方法
    func userWillLogin(visitorView: PJVisitorLoginView)
    func userWillRegsiter(visitorView: PJVisitorLoginView)
}

class PJVisitorLoginView: UIView {

    //定义代理对象
    weak var delegate: PJVisitorLoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(title: String, imageName: String, isHome: Bool = false){
        self.largeHouse.isHidden = !isHome
        self.coverView.isHidden = !isHome
        self.tipLabel.text = title
        self.circleView.image = UIImage(named: imageName)
        
        if isHome{
          startAnimation()
        }
    }
    
    private func startAnimation(){
        //给圈圈添加动画效果
        //1.实例化基本动画对象
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        //2.设置动画效果
        animation.toValue = 2 * M_PI
        animation.duration = 15
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        //3.将动画对象添加到图层
        circleView.layer.add(animation, forKey: nil)
    }
    
    private func setUpUI(){
        //先添加子视图,再添加约束
        addSubview(circleView)
        addSubview(coverView)
        addSubview(largeHouse)
        addSubview(tipLabel)
        addSubview(loginBtn)
        addSubview(registerBtn)
        
        //添加约束
        circleView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-80)
        }
        largeHouse.snp.makeConstraints { (make) in
            make.center.equalTo(circleView)
        }
        coverView.snp.makeConstraints { (make) in
            make.center.equalTo(circleView)
        }
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(circleView.snp.bottom).offset(16)
            make.centerX.equalTo(circleView)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tipLabel.snp.bottom).offset(16)
            make.right.equalTo(tipLabel)
            make.width.equalTo(100)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tipLabel.snp.bottom).offset(16)
            make.left.equalTo(tipLabel)
            make.width.equalTo(100)
        }
        
        
        tipLabel.preferredMaxLayoutWidth = 230
        backgroundColor = UIColor(white: 237.0/255.0, alpha: 1)
        
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
    }
    
    //登录
    @objc private func loginClick(){
        //代理对象执行协议方法
        delegate?.userWillLogin(visitorView: self)
    }
    
    //注册
    @objc private func registerClick(){
        //代理对象执行协议方法
        delegate?.userWillRegsiter(visitorView: self)
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
