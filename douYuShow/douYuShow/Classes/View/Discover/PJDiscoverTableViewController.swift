//
//  PJDiscoverTableViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/10.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJDiscoverTableViewController: PJBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userLogin {
            //没有登录才需要设置访客视图的信息
            visitorView.updateUI(title: "关注一些人,回到这里看看有什么惊喜哟", imageName: "visitordiscover_image_message")
        }
    }

}
