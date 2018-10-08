//
//  PJComposeViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/10/8.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        //背景颜色
        view.backgroundColor = UIColor.white
        setupNav()
        view.addSubview(composeTextView)
        
        composeTextView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    private func setupNav(){
        //左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", backImage:  nil, imageName: nil, target: self, action: #selector(cancelAction))
        //右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        //默认情况下右侧按钮不可点击
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.titleView = titleView
    }
    
    //MARK:懒加载控件
    //titleView
    private lazy var titleView: UILabel = {
        //先获取到用户的名字
        let name = PJUserAccountViewModel.shared.account?.name ?? ""
        //拼接最终显示的内容
        let text = "发微博" + "\n" + name
        //计算下对应 range
        let range = (text as NSString).range(of: name)
        //借助富文本 NSMutableAttributesString
        let attr = NSMutableAttributedString(string: text)
        //设置富文本属性
        attr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName: ThemeColor], range: range)
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.textAlignment = .center
        //赋值富文本
        lab.attributedText = attr
        lab.sizeToFit()
        return lab
    }()
    
    //发送按钮
    fileprivate lazy var sendButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        button.frame.size = CGSize(width: 50, height: 50)
        button.setTitle("发送", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FONTSIZEOFNORMAL)
        button.setTitleColor(UIColor.darkGray, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .disabled)
        button.setBackgroundImage(UIImage(named: "common_button_orange"), for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), for: .highlighted)
        return button
    }()

    fileprivate lazy var composeTextView: PJComposeTextView = {
        let view = PJComposeTextView()
        //设置代理
        view.delegate = self
        //允许上下滚动
        view.alwaysBounceVertical = true
        view.font = UIFont.systemFont(ofSize: 16)
        view.placeholder = "今天天气怎么样"
        return view
    }()
}

//MARK:UITextViewDelegate
extension PJComposeViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        //是否有文字
        navigationItem.rightBarButtonItem?.isEnabled = composeTextView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.composeTextView.resignFirstResponder()
    }
}

extension PJComposeViewController{
    @objc fileprivate func cancelAction(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendAction(){
        print("发送按钮点击")
    }
}
