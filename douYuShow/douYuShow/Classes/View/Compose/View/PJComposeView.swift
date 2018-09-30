//
//  PJComposeView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/30.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import pop

class PJComposeView: UIView {
    
    var composeButtons:[PJComposeButton] = [PJComposeButton]()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:供外界调用的方法
    class func show(target: UIViewController){
        //实例化 composeView
        let composeView = PJComposeView()
        //实例化一个 composeView
        target.view.addSubview(composeView)
        //设置6个按钮的动画
        composeView.setupComposeButtonAnim(isUp: true)
    }
    
    //MARK:懒加载控件
    //背景图片
    private lazy var bgImageView: UIImageView = {
        let img = UIImageView(image: UIImage.getScreenSnap()?.applyLightEffect())
        return img
    }()
    //背景图片
    private lazy var sloganImageView: UIImageView = UIImageView(imgName: "compose_slogan")
    
    private func setupUI(){
        backgroundColor = randomColor()
        //添加控件
        addSubview(bgImageView)
        addSubview(sloganImageView)
        //设置约束
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        sloganImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(100)
        }
        addChildComposeButtons()
    }
}

extension PJComposeView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //设置动画
        setupComposeButtonAnim(isUp: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
          self.removeFromSuperview()
        }
    }
}

extension PJComposeView{
    fileprivate func setupComposeButtonAnim(isUp: Bool){
        //临界值
        let buttonYMargin: CGFloat = isUp == true ? -350 : 350
        //最终遍历的数组
        let tempArray = isUp == true ? composeButtons : composeButtons.reversed()
        //遍历数组
        for (i,button) in tempArray.enumerated(){
            //实例化弹簧动画对象
            let anSpring = POPSpringAnimation(propertyNamed: kPOPViewCenter)!
            //设置 toValue
            anSpring.toValue = CGPoint(x: button.center.x, y: button.center.y + buttonYMargin)
            //开始时间 系统绝对时间
            anSpring.beginTime = CACurrentMediaTime() + Double(i) * 0.025
            //振幅
            anSpring.springBounciness = 10.0
            //设置动画
            button.pop_add(anSpring,forKey:nil)
        }
    }
}

extension PJComposeView{
    fileprivate func addChildComposeButtons(){
        //得到数据
        let composeDataArray = loadComposePlist()
        //计算按钮的宽度和高度
        let buttonW: CGFloat = 80
        let buttonH: CGFloat = 110
        //计算按钮的间距
        let buttonItem = (ScreenWidth - buttonW * 3) / 4
        //循环创建按钮
        for (i,model) in composeDataArray.enumerated(){
            //计算行数和列数
            let row = CGFloat(i / 3)
            let col = CGFloat(i % 3)
            //实例化 button
            let button = PJComposeButton()
            //设置 image
            button.setImage(UIImage(named: model.icon ?? ""), for: .normal)
            //设置 title
            button.setTitle(model.title, for: .normal)
            button.frame = CGRect(x: buttonItem + (buttonW + buttonItem) * col, y: 100 + (buttonH + buttonItem) * row, width: buttonW, height: buttonH)
            //添加按钮
            addSubview(button)
        }
        
    }
    
    fileprivate func loadComposePlist() -> [PJComposeModel]{
        //获取文件
        let file = Bundle.main.path(forResource: "compose.plist", ofType: nil)!
        //得到 pist 文件的数组
        let plistArray = NSArray(contentsOfFile: file)!
        //通过 yymodel 字典数组转换模型数组
        let tempArray = NSArray.yy_modelArray(with: PJComposeModel.self, json: plistArray) as! [PJComposeModel]
        return tempArray
    }
}


