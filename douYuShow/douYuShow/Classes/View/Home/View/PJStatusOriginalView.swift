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
    
    //MARK:视图属性
    /// 头像图片
    private lazy var headImageView: UIImageView = UIImageView(imgName: "avatar_default")
    
    /// 昵称
    private lazy var nameLabel: UILabel = UILabel(title: "昵称", textColor: UIColor.black, fontSize: FONTSIZEOFNORMAL)
    
    /// 会员图片
    private lazy var membershipImageView : UIImageView = UIImageView(imgName: "common_icon_membership")
    
    /// 微博时间
    private lazy var timeLabel: UILabel = UILabel(title: "微博时间", textColor:  ThemeColor, fontSize: FONTSIZEOFSMALL)
    
    /// 微博来源
    private lazy var sourceLable: UILabel = UILabel(title: "微博来源", textColor:  ThemeColor, fontSize: FONTSIZEOFSMALL)
    
    /// 头像角标
    private lazy var avatarImageView : UIImageView = UIImageView(imgName: "avatar_vgirl")
    
    /// 微博内容
    private lazy var contentLabel: UILabel = UILabel(title: "没有内容", textColor: UIColor.black, fontSize: FONTSIZEOFNORMAL)
    
    /// 微博配图
    private lazy var pictureView: PJStatusPictureView = PJStatusPictureView()
    
    //MARK:UI 设置
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
        addSubview(pictureView)
        //2添加约束
        headImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(HOMECELLMARGIN)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView.snp.right).offset(HOMECELLMARGIN)
            make.top.equalTo(headImageView)
        }
        membershipImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(HOMECELLMARGIN)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headImageView)
        }
        sourceLable.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(HOMECELLMARGIN)
            make.top.equalTo(timeLabel)
        }
        avatarImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(headImageView.snp.right)
            make.centerY.equalTo(headImageView.snp.bottom)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView)
            make.top.equalTo(headImageView.snp.bottom).offset(HOMECELLMARGIN)
            make.width.equalTo(ScreenWidth - 2 * HOMECELLMARGIN)
        }
        pictureView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.left.equalTo(HOMECELLMARGIN)
            make.top.equalTo(contentLabel.snp.bottom).offset(HOMECELLMARGIN)
        }
        self.snp.makeConstraints { (make) in
            make.bottom.equalTo(pictureView).offset(HOMECELLMARGIN)
        }
    }
    
}
