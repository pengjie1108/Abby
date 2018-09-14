//
//  PJStatusRetweetView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/14.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import SnapKit

/// 转发视图
class PJStatusRetweetView: UIView {

    var retweetViewBottomConstraint: Constraint?
    
    var statusViewModel: PJStatusViewModel?{
        didSet{
            //微博正文赋值
            contentLabel.text = statusViewModel?.homeModel?.retweeted_status?.text
            //卸载约束
            retweetViewBottomConstraint?.deactivate()
            
            if let picUrls = statusViewModel?.homeModel?.pic_urls, picUrls.count > 0 {
                //有配图
                pictureView.picUrls = picUrls
                //设置约束
                self.snp.makeConstraints { (make) in
                    retweetViewBottomConstraint = make.bottom.equalTo(pictureView).offset(HOMECELLMARGIN).constraint
                }
                pictureView.isHidden = false
            }else{
                //没有配图
                self.snp.makeConstraints { (make) in
                    retweetViewBottomConstraint = make.bottom.equalTo(contentLabel).offset(HOMECELLMARGIN).constraint
                }
                pictureView.isHidden = true
            }
            
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 转发微博正文
    private lazy var contentLabel: UILabel = UILabel(title: "转发...", textColor: UIColor.darkGray, fontSize: FONTSIZEOFNORMAL)
    /// 配图
    private lazy var pictureView: PJStatusPictureView = PJStatusPictureView()
    
    // MARK: 转发微博的 UI 设置
    private func setupUI(){
        backgroundColor = randomColor()
        //1添加控件
        addSubview(contentLabel)
        addSubview(pictureView)
        //2添加约束
        contentLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(HOMECELLMARGIN)
            make.width.equalTo(ScreenWidth - 2 * HOMECELLMARGIN)
        }
        pictureView.snp.makeConstraints { (make) in
            make.left.equalTo(HOMECELLMARGIN)
            make.top.equalTo(contentLabel.snp.bottom).offset(HOMECELLMARGIN)
        }
        self.snp.makeConstraints { (make) in
//            make.bottom.equalTo(pictureView).offset(HOMECELLMARGIN)
            retweetViewBottomConstraint = make.bottom.equalTo(pictureView).offset(HOMECELLMARGIN).constraint
        }
    }
    
}
