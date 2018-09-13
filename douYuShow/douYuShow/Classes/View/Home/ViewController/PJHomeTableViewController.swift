//
//  PJHomeViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/8/31.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import YYModel

//cell 重用标识符
private let CELLID = "reuseIdentifier"
class PJHomeTableViewController: PJBaseTableViewController {
    
//    var dataArray:[PJHomeModel] = [PJHomeModel]()
    var homeViewModel: PJHomeViewModel = PJHomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        
        if !userLogin {
            visitorView.updateUI(title: "关注一些人,回到这里看看有什么惊喜哟", imageName: "visitordiscover_feed_image_smallicon",isHome: true)
            return
        }
        setupTableViewInfo()
        loadData()
    }
}

//MARK: 设置 tableView 信息
extension PJHomeTableViewController{
    fileprivate func setupTableViewInfo(){
        //注册 cell
        tableView.register(PJHomeCell.self, forCellReuseIdentifier: CELLID)
        //设置 cell 高度
        tableView.rowHeight = 200
    }
}

//MARK: 请求微博首页数据
extension PJHomeTableViewController{
    fileprivate func loadData(){
        homeViewModel.getHomeData { (isSuccess) in
            //请求失败
            if !isSuccess{
                print("请求失败")
                return
            }
            //请求成功
            self.tableView.reloadData()
        }
    }
}

extension PJHomeTableViewController{

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return homeViewModel.dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath) as! PJHomeCell
        return cell
    }
}



extension PJHomeTableViewController{
    fileprivate func setNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(btnClick))
    }
    
    @objc fileprivate func btnClick(){
        let demo = UIViewController()
        navigationController?.pushViewController(demo, animated: true)
    }
    
    func back() {
        
    }
}














