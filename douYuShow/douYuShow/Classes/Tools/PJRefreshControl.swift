//
//  PJRefreshControl.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/28.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

private let refreshControlH: CGFloat = 50

enum PJRefreshControlType: String{
    case normal = "正常中"
    case pulling = "下拉中"
    case refreshing = "刷新中"
}

class PJRefreshControl: UIControl {
    
    var scrollView: UIScrollView?
    
    //MARK: 懒加载控件
    fileprivate lazy var messageLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textAlignment = .center
        lab.text = "正常中"
        return lab
    }()
    
    fileprivate lazy var refreshImageView: UIImageView = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
    
    fileprivate lazy var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    var refreshControlType: PJRefreshControlType = .normal{
        didSet{
            messageLabel.text = refreshControlType.rawValue
            switch refreshControlType {
                //正常
            case .normal:
                if oldValue == .refreshing{
                    UIView.animate(withDuration: 0.25, animations: {
                        self.scrollView?.contentInset.top -= refreshControlH
                        //停止风火轮动画
                        self.indicatorView.stopAnimating()
                    }, completion: {(_) in
                        //显示指示箭头
                        self.refreshImageView.isHidden = false
                    })
                }
                //设置动画
                UIView.animate(withDuration: 0.25) {
                    self.refreshImageView.transform = CGAffineTransform.identity
                }
                //下拉中
            case .pulling:
                UIView.animate(withDuration: 0.25) {
                    self.refreshImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-3 * M_PI))
                }
                //刷新中
            case .refreshing:
                UIView.animate(withDuration: 0.25, animations: {
                    self.scrollView?.contentInset.top += refreshControlH
                    //隐藏指示箭头
                    self.refreshImageView.isHidden = true
                    //开启风火轮动画
                    self.indicatorView.startAnimating()
                }, completion: { (_) in
                    //发送事件 告知外界监听
                    self.sendActions(for: UIControlEvents.valueChanged)
                    })
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: -refreshControlH, width: UIScreen.main.bounds.size.width, height: refreshControlH))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:供外界调用的方法 结束刷新
    func endRefreshing(){
        //把控件的状态改为正常
        refreshControlType = .normal
    }
    
    private func setupUI(){
        backgroundColor = UIColor.orange
        //添加控件
        addSubview(messageLabel)
        addSubview(refreshImageView)
        addSubview(indicatorView)
        //取消自动布局
        
        //设置约束
        /*
         01 约束的对象
         02 约束对象的部位
         03 约束条件
         04 相对于约束的对象
         05 相对于约束的对象部位
         06 倍数
         07 浮点数 offset
         */
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        
        refreshImageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: refreshImageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: -35))
        addConstraint(NSLayoutConstraint(item: refreshImageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: indicatorView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: -35))
        addConstraint(NSLayoutConstraint(item: indicatorView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
    }
}

extension PJRefreshControl{
    //监听将要添加到哪个控件上
    override func willMove(toSuperview newSuperview: UIView?) {
        guard let view = newSuperview as? UIScrollView else {
            return
        }
        scrollView = view
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //计算使用的临界值
        let contentOffsetMaxY = -(self.scrollView!.contentInset.top + refreshControlH)
        //得到 contentOffset
        let contentOffsetY = -self.scrollView!.contentOffset.y
        //如果拖动中没有松手
        if self.scrollView!.isDragging{
            //- contentOffsetY > -114 且状态为下拉中(正常中)
            if contentOffsetY >= contentOffsetMaxY && refreshControlType == .pulling{
                print("正常")
                refreshControlType = .normal
            }else if contentOffsetY < contentOffsetMaxY && refreshControlType == .normal{
                print("下拉中")
                refreshControlType = .pulling
            }
        }else{
            //如果拖动后松手
            if refreshControlType == .pulling{
                refreshControlType = .refreshing
                print("刷新中")
            }
        }
    }
}








