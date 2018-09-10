//
//  PJHomeViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/8/31.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJHomeViewController: PJBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        
//        setupUI()
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

extension PJHomeViewController{
    fileprivate func setNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(btnClick))
    }
    func btnClick(){
        let demo = UIViewController()
        navigationController?.pushViewController(demo, animated: true)
        print("11")
    }
}
