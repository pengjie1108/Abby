//
//  PJBaseNavController.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/3.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJBaseNavController: UINavigationController, UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let count = viewControllers.count
        if count > 0{
            //设置需要返回的导航栏item
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", backImage: "navigationbar_back_withtext", target: self, action: #selector(back))
            viewController.view.backgroundColor = UIColor.white
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    @objc private func back() {
        let _ = self.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
