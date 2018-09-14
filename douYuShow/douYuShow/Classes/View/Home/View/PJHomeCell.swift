//
//  PJHomeCell.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/13.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

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

class PJHomeCell: UITableViewCell {

    var statusViewModel: PJStatusViewModel?{
        didSet{
            originalView.statusViewModel = statusViewModel
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var originalView: PJStatusOriginalView = PJStatusOriginalView()
    
    private func setupUI(){
        backgroundColor = randomColor()
        //添加控件
        contentView.addSubview(originalView)
        //添加约束
        originalView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(contentView)
//            make.height.equalTo(50)
        }
    }

}
