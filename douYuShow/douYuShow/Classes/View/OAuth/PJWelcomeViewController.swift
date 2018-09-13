//
//  PJWelcomeViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/13.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import SDWebImage

private let iconW: CGFloat = 85
private let bottomMargin: CGFloat = 180

class PJWelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
//        startAnimation()
    }

    //用户头像
    private lazy var iconView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "avatar_default_big"))
    
    //欢迎回来
    private lazy var welcomeLabel: UILabel = UILabel(title: "欢迎回来", textColor:  UIColor.darkGray, fontSize: 15)
    
    private func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-bottomMargin)
            make.size.equalTo(CGSize(width: iconW, height: iconW))
        }
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(20)
        }
        
        welcomeLabel.alpha = 0;
        //用户头像圆角
        iconView.layer.cornerRadius = iconW / 2
        iconView.layer.masksToBounds = iconView.layer.cornerRadius > 0
        
        //设置用户头像
//        print(PJUserAccountViewModel.shared.headURL)
        iconView.sd_setImage(with: PJUserAccountViewModel.shared.headURL)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    private func startAnimation() {
        //iconView 动画效果
        let offset = -(ScreenHeight - bottomMargin - iconW)
        
        self.iconView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.view).offset(offset)
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: [], animations: {
            //强制刷新
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            UIView.animate(withDuration: 1, animations: {
                self.welcomeLabel.alpha = 1
            }, completion: { (_) in
                //跳转到首页(tabBar 控制器)
                UIApplication.shared.keyWindow?.rootViewController = PJMainTabBarController()
            })
        })
    }

}
