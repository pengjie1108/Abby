//
//  PJStatusBottomView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/14.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJStatusBottomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = UIColor(white: 235/255, alpha: 1)
        //01添加控件
        let retweetButton = addChildButtons(imgName: "timeline_icon_retweet", title: "转发")
        let commentButton = addChildButtons(imgName: "timeline_icon_comment", title: "评论")
        let unlikeButton = addChildButtons(imgName: "timeline_icon_unlike", title: "赞")
        let line1 = addChildLines()
        let line2 = addChildLines()
        
        //02添加约束
        retweetButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(commentButton)
        }
        commentButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(retweetButton.snp.right)
            make.width.equalTo(unlikeButton)
        }
        unlikeButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.left.equalTo(commentButton.snp.right)
        }
        line1.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(retweetButton.snp.right)
        }
        line2.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(unlikeButton.snp.left)
        }
    }

}

extension PJStatusBottomView{
    fileprivate func addChildButtons(imgName: String, title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FONTSIZEOFNORMAL)
        button.setImage(UIImage(named: imgName), for: .normal)
        button.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), for: .normal)
        button.setBackgroundImage(UIImage(named:"timeline_card_bottom_background_highlighted"), for: UIControlState.highlighted)
        addSubview(button)
        return button
    }
    
    fileprivate func addChildLines() -> UIImageView{
        let img = UIImageView(imgName: "timeline_card_bottom_line")
        addSubview(img)
        return img
    }
}
