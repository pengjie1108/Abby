//
//  PJStatusOriginalView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/13.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJStatusOriginalView: UIView {
    
    var statusViewModel: PJStatusViewModel?{
        didSet{
           //vm设置后  在这里给子控件进行赋值

           nameLabel.text = statusViewModel?.homeModel?.user?.name

           headImageView.pj_setImage(urlString: statusViewModel?.homeModel?.user?.profile_image_url, placeholderImgName: "avatar_default")

           membershipImageView.image = statusViewModel?.mbrankImage
            
           avatarImageView.image = statusViewModel?.verifiedImage

           contentLabel.text = statusViewModel?.homeModel?.text
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var headImageView: UIImageView = UIImageView(imgName: "avatar_default")
    
    private lazy var nameLabel: UILabel = UILabel(title: "昵称", textColor: UIColor.black, fontSize: 14)
    
    private lazy var membershipImageView : UIImageView = UIImageView(imgName: "common_icon_membership")
    
    private lazy var timeLabel: UILabel = UILabel(title: "微博时间", textColor:  UIColor.orange, fontSize: 10)
    
    private lazy var sourceLable: UILabel = UILabel(title: "微博来源", textColor:  UIColor.orange, fontSize: 10)
    
    private lazy var avatarImageView : UIImageView = UIImageView(imgName: "avatar_vgirl")
    
    private lazy var contentLabel: UILabel = UILabel(title: "没有内容", textColor: UIColor.black, fontSize: 14)
    
    private func setupUI(){
        backgroundColor = randomColor()
        //1添加控件
        addSubview(headImageView)
        addSubview(nameLabel)
        addSubview(membershipImageView)
        addSubview(timeLabel)
        addSubview(sourceLable)
        addSubview(avatarImageView)
        addSubview(contentLabel)
        //2添加约束
        headImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView.snp.right).offset(10)
            make.top.equalTo(headImageView)
        }
        membershipImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(10)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headImageView)
        }
        sourceLable.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(10)
            make.top.equalTo(timeLabel)
        }
        avatarImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(headImageView.snp.right)
            make.centerY.equalTo(headImageView.snp.bottom)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView)
            make.top.equalTo(headImageView.snp.bottom).offset(10)
            make.width.equalTo(ScreenWidth - 20)
        }
        self.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentLabel).offset(10)
        }
    }
    
}