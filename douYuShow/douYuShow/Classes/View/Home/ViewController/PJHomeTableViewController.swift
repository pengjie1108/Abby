//
//  PJHomeViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/8/31.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import YYModel

class PJHomeTableViewController: PJBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        
        if !userLogin {
            visitorView.updateUI(title: "关注一些人,回到这里看看有什么惊喜哟", imageName: "visitordiscover_feed_image_smallicon",isHome: true)
            return
        }
        loadData()
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

//请求微博首页数据
extension PJHomeTableViewController{
    fileprivate func loadData(){
        //URL
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //请求参数
        let params = ["access_token": PJUserAccountViewModel.shared.accessToken]
        //发送请求
        PJNetworkTools.shared.request(method: .GET, urlString: urlString, parameters: params) { (response, error) in
            if error != nil{
                print("请求失败")
                return
            }
//            print(response!)
            //解析 response
              //在 if let 或者 guard let 中 转类型的时候 一般情况 都需要使用的是 as
            guard let res = response as? [String: Any] else {
                return
            }
            //判断是否是 nil 而且是字典,获取字典中key 中数组数组
            guard let resArr = res["statuses"] as? [[String: Any]] else{
                return
            }
            //字典转模型
            let statusArray = NSArray.yy_modelArray(with: PJHomeModel.self, json: resArr) as! [PJHomeModel]
            
        }
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














