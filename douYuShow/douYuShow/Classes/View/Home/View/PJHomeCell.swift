//
//  PJHomeCell.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/13.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import SnapKit

//首页中需要使用的间距值
let HOMECELLMARGIN: CGFloat = 10

class PJHomeCell: UITableViewCell {

    //记录底部视图的顶部约束
    var bottomViewTopConstaint: Constraint?
    
    var statusViewModel: PJStatusViewModel?{
        didSet{
            //给原创微博 赋值
            originalView.statusViewModel = statusViewModel
            //1 卸载底部视图的顶部约束
            bottomViewTopConstaint?.deactivate()
            
            //2 判断retweeted_status 是否为 nil
            if let _ = statusViewModel?.homeModel?.retweeted_status{
                //不为空 -> 转发微博
                  //给转发微博 赋值
                retweetView.statusViewModel = statusViewModel
                
                bottomView.snp.makeConstraints { (make) in
                    bottomViewTopConstaint = make.top.equalTo(retweetView.snp.bottom).constraint
                }
                retweetView.isHidden = false
            }else{
                //为空 -> 转发微博
                bottomView.snp.makeConstraints { (make) in
                    bottomViewTopConstaint = make.top.equalTo(originalView.snp.bottom).constraint
                }
                retweetView.isHidden = true
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 原创微博
    private lazy var originalView: PJStatusOriginalView = PJStatusOriginalView()
    
    /// 转发微博
    private lazy var retweetView: PJStatusRetweetView = PJStatusRetweetView()
    
    /// 底部控件
    private lazy var bottomView: PJStatusBottomView = PJStatusBottomView()

    private func setupUI(){
//        backgroundColor = randomColor()
        backgroundColor = UIColor(white: 235/255, alpha: 1)
        //添加控件
        contentView.addSubview(originalView)
        contentView.addSubview(bottomView)
        contentView.addSubview(retweetView)
        //添加约束
        originalView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(8)
            make.left.right.equalTo(contentView)
        }
        retweetView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.top.equalTo(originalView.snp.bottom)
        }
        bottomView.snp.makeConstraints { (make) in
            bottomViewTopConstaint = make.top.equalTo(retweetView.snp.bottom).constraint
//            make.top.equalTo(retweetView.snp.bottom)
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(35)
        }
        
    }

}
/*
 原创微博,转发微博,底部视图
 -原创微博
 -头像
 -昵称
 -会员等级
 -认证
 -微博正文
 -时间
 -来源
 -配图(可能存在)
 -个数(0-9)
 -转发微博(可能存在)
 -微博正文
 -配图
 -底部视图
 -转发
 -评论
 -赞
 */
