//
//  PJTabBar.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/10.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJTabBar: UITabBar {

    //定义一个闭包 作为按钮的点击事件
    var clickClosure : ((PJTabBar) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    //通过解档的方式获取一个视图控件
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        //添加"+"按钮
        self.addSubview(plusBtn)
        //添加监听事件
        plusBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
    }
    
    //一旦通过消息机制调用的方法添加了 private 关键字修改,那么该方法就成为一个绝对私有的方法,并且对运行时不可见
    @objc private func btnClick(){
        //执行闭包
        clickClosure?(self)
    }
    
    //通过懒加载得到 plusBtn
    lazy var plusBtn: UIButton = {
        let btn = UIButton()
        //设置图片和背景图片
        btn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        btn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
        btn.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: .highlighted)
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.bounds.size.width / 5
        let h = self.bounds.height
        //1.遍历 tabbar 所有子视图
        var index = 0
        for subView in subviews {
            //2.判断子视图类型是不是需要tabBarButton类型
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
                //3.对tabBarButton 类型做操作
                subView.frame = CGRect(x: w * CGFloat(index), y: 0, width: w, height: h)
                index += (index == 1 ? 2 : 1)
            }
        }
        //设置加号按钮的 frame
        plusBtn.center = CGPoint(x: self.center.x, y: self.bounds.height * 0.5)
        plusBtn.bounds.size = CGSize(width: w, height: h)
    }

}
