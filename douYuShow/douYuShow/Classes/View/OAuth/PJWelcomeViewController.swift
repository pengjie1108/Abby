//
//  PJWelcomeViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/13.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJWelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
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
            make.bottom.equalTo(self.view).offset(-180)
        }
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(20)
        }
        
//        welcomeLabel.alpha = 0;
    }

}
