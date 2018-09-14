//
//  PJStatusRetweetView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/14.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

/// 转发视图
class PJStatusRetweetView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var contentLabel:UILabel = UILabel(title: "转发...", textColor: UIColor.darkGray, fontSize: FONTSIZEOFNORMAL)
    
    private func setupUI(){
        backgroundColor = randomColor()
        //1添加控件
        addSubview(contentLabel)
        //2添加约束
        contentLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(HOMECELLMARGIN)
            make.width.equalTo(ScreenWidth - 2 * HOMECELLMARGIN)
        }
        self.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentLabel).offset(HOMECELLMARGIN)
        }
    }
    
}
