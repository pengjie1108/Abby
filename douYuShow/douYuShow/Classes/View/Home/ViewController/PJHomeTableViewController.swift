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
    
    var homeViewModel: PJHomeViewModel = PJHomeViewModel()
    
    //MARK:懒加载控件
    //风火轮
    fileprivate lazy var footerView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        //设置颜色
        view.color = ThemeColor
        return view
    }()
    //系统下拉刷新控件
    fileprivate lazy var pjRefreshControl: PJRefreshControl = {
        let view = PJRefreshControl()
        //添加监听事件
        view.addTarget(self, action: #selector(refreshActioin), for: UIControlEvents.valueChanged)
        return view
    }()
    //下拉刷新提示控件
    fileprivate lazy var pullDownTipLabel: UILabel = {
        let lab = UILabel()
        lab.frame = CGRect(x: 0, y: 64 - 30, width: ScreenWidth, height: 30)
        lab.backgroundColor = ThemeColor
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: FONTSIZEOFNORMAL)
        lab.textAlignment = .center
        //隐藏状态
        lab.isHidden = true
        return lab
    }()

    //MARK:视图加载
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        if !userLogin {
            visitorView.updateUI(title: "关注一些人,回到这里看看有什么惊喜哟", imageName: "visitordiscover_feed_image_smallicon",isHome: true)
            return
        }
        setupUI()
        setupTableViewInfo()
        loadData()
    }
    
    //MARK:设置控件
    private func setupUI(){
        navigationController?.view.insertSubview(pullDownTipLabel, belowSubview: navigationController!.navigationBar)
    }
}

extension PJHomeTableViewController{
    //下拉刷新监听方法
    @objc fileprivate func refreshActioin(){
        loadData()
    }
}

//MARK: 设置 tableView 信息
extension PJHomeTableViewController{
    fileprivate func setupTableViewInfo(){
        //注册 cell
        tableView.register(PJHomeCell.self, forCellReuseIdentifier: CELLID)
        //设置 cell 高度
//        tableView.rowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        //隐藏 cell 分割线
        tableView.separatorStyle = .none
        //设置 footerview
        tableView.tableFooterView = footerView
        //添加 refreshcontrol
        tableView.addSubview(pjRefreshControl)
    }
}

//MARK: 请求微博首页数据
extension PJHomeTableViewController{
    fileprivate func loadData(){
        homeViewModel.getHomeData(isPullUp: footerView.isAnimating) { (isSuccess,count) in
            self.endRefreshing()
            //请求失败
            if !isSuccess {
                print("请求失败")
                return
            }else {
                self.tableView.reloadData()
                if !self.footerView.isAnimating{
                    
                }
            }
            //请求成功
            self.tableView.reloadData()
        }
    }
    
    //设置下拉刷新提示控件动画,+设置显示文字+ 只有 footerView 没有动画的时候 才可以首次请求数据和下拉刷新
    fileprivate func showPullDownTipLabel(count: Int){
        //防止用户快速刷新 导致 pullDownTipLabel 重复下移的 bug
        if self.pullDownTipLabel.isHidden == false{
            return
        }
        self.pullDownTipLabel.isHidden = false
        //定义一个字符串
        var text = ""
        //设置 pullDownTipLabel 显示的文字
        if count <= 0{
            text = "您已经是最新的微薄"
        }else{
            text = "您更新了\(count)条微薄"
        }
        self.pullDownTipLabel.text = text
        
        UIView.animate(withDuration: 1, animations: {
            self.pullDownTipLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        }) { (_) in
            //
            UIView.animateKeyframes(withDuration: 1, delay: 1, options: [], animations: {
                self.pullDownTipLabel.transform = CGAffineTransform.identity
            }, completion: { (_) in
                self.pullDownTipLabel.isHidden = true
            })
        }
    }
    
    //统一定义动画
    fileprivate func endRefreshing(){
        //停止动画
        self.footerView.stopAnimating()
        self.pjRefreshControl.endRefreshing()
    }
}

extension PJHomeTableViewController{

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return homeViewModel.dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath) as! PJHomeCell
        //cell 的 VM 和首页的 VM 传递
        cell.statusViewModel = homeViewModel.dataArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == homeViewModel.dataArray.count - 1 && !footerView.isAnimating{
            //开启动画
            footerView.startAnimating()
            //请求数据
            loadData()
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














