//
//  PJHomeViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/8/31.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJHomeTableViewController: PJBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        
        if !userLogin {
            visitorView.updateUI(title: "关注一些人,回到这里看看有什么惊喜哟", imageName: "visitordiscover_feed_image_smallicon",isHome: true)
        }
    }
    private func setNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(btnClick))
    }
    
    @objc private func btnClick(){
        let demo = UIViewController()
        navigationController?.pushViewController(demo, animated: true)
    }
    
    func back() {
        
    }
    
    private func setupUI(){
//        navigationController?.view.insertSubview(<#T##view: UIView##UIView#>, belowSubview: (navigationController?.navigationBar)!)
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    

}

//extension PJHomeTableViewController{
//    fileprivate func setNavBar(){
//        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(btnClick))
//    }
//    func btnClick(){
//        let demo = UIViewController()
//        navigationController?.pushViewController(demo, animated: true)
//        print("11")
//    }
//}
