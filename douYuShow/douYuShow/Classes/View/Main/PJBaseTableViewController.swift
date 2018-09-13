//
//  PJBaseTableViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/3.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJBaseTableViewController: UITableViewController,PJVisitorLoginViewDelegate{
    
    
    func userWillLogin(visitorView: PJVisitorLoginView) {
        print(#function)
        let oauth = PJOAuthViewController()
        let nav = UINavigationController(rootViewController: oauth)
        self.present(nav, animated: true, completion: nil)
    }
    
    func userWillRegsiter(visitorView: PJVisitorLoginView) {
        print(#function)
    }
    
    var userLogin = PJUserAccountViewModel.shared.userLogin
    
    lazy var visitorView = PJVisitorLoginView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if userLogin == true {
            super.loadView()
        }else{  
            self.view = visitorView
            //设置代理对象
            self.visitorView.delegate = self
        }
    }

}
