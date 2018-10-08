//
//  PJComposeTextView.swift
//  douYuShow
//
//  Created by jie peng on 2018/10/8.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJComposeTextView: UITextView {
    
    //重写 font 属性
    override var font: UIFont?{
        didSet{
            //设置占位文字的大小
            placeholderLabel.font = font
        }
    }
    
    //添加一个属性 赋值
    var placeholder: String? {
        didSet{
            placeholderLabel.text = placeholder
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        //添加控件
        addSubview(placeholderLabel)
        //添加约束
        placeholderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(8)
            make.width.equalTo(ScreenWidth - 10)
        }
        //注册系统通知监听 textView文字改变
        NotificationCenter.default.addObserver(self, selector: #selector(textViewTextDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }

    //MARK:懒加载控件
    //占位文字
    fileprivate lazy var placeholderLabel : UILabel = {
       let lab = UILabel()
       lab.textColor = UIColor.darkGray
       lab.numberOfLines = 0
       return lab
    }()
}

//MARK:监听文字改变
extension PJComposeTextView{
    //监听文字变化
    @objc fileprivate func textViewTextDidChange(){
        placeholderLabel.isHidden = self.hasText
    }
}
