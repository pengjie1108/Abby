//
//  PJMainTabBarController.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/3.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()
        
        //自定义 tabbar, 只读属性
        let pjTabBar = PJTabBar()
        self.setValue(pjTabBar, forKey: "tabBar")
        
        //监听按钮点击事件
        pjTabBar.clickClosure = {[weak self] (tabbar:PJTabBar) -> () in
            print("点击加号按钮")
        }
    }

    //批量添加子控制器
    private func addChildViewControllers() {
        //首页 VC
        addchildViewController(vc: PJHomeTableViewController(), title: "首页", imageName: "tabbar_home")
        //消息 VC
        addchildViewController(vc: PJMessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        //发现 VC
        addchildViewController(vc: PJDiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        //我 VC
        addchildViewController(vc: PJProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    
    private func addchildViewController(vc:UIViewController, title: String, imageName:String){
        //单独设置文字在某些版本不能够正常显示,必须同时设置 Image
        vc.tabBarItem.title = title
        vc.navigationItem.title = title
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        //设置选中图片,和选中文字颜色
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: .selected)
//        vc.tabBarItem.badgeValue = "10"
        vc.tabBarItem.badgeColor = UIColor.purple
        //包装到导航视图控制器
        let nav = PJBaseNavController(rootViewController: vc)
        //添加到 tabbarController
        addChildViewController(nav)
    }
    
}
