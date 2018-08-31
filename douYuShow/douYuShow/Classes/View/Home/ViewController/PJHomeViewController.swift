//
//  PJHomeViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/8/31.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJHomeViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
    }

    extension PJHomeViewController{
    func setNavBar() ->  {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: "navigation_pop", style: self, target: <#T##Any?#>, action: <#T##Selector?#>)
    }
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
