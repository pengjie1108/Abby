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
    //记录 PJMainViewController
    var target: UIViewController?
    
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
        //赋值
        composeView.target = target
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
    
    //广告图片
    private lazy var sloganImageView: UIImageView = UIImageView(imgName: "compose_slogan")
    
    private func setupUI(){
//        backgroundColor = randomColor()
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
          self.removeFromSuperview()
        }
    }
}

//MARK:设置六个按钮动画
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

//MARK:六个按钮布局
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
            //赋值
            button.composeModel = model
            //添加事件
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            //设置 image
            button.setImage(UIImage(named: model.icon ?? ""), for: .normal)
            //设置 title
            button.setTitle(model.title, for: .normal)
            button.frame = CGRect(x: buttonItem + (buttonW + buttonItem) * col, y: ScreenHeight + (buttonH + buttonItem) * row, width: buttonW, height: buttonH)
            //添加按钮到数组中
            composeButtons.append(button)
            //添加按钮
            addSubview(button)
        }
    }
    
    @objc fileprivate func buttonClick(button: PJComposeButton){
        //设置按钮动画
        UIView.animate(withDuration: 0.25, animations: {
            //遍历保存按钮数组
            for composeButton in self.composeButtons{
                //透明度
                composeButton.alpha = 0.2
                //判断哪个点击了
                if composeButton == button{
                    composeButton.transform = CGAffineTransform(scaleX: 2, y: 2)
                }else{
                    composeButton.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                }
            }
            
        }) { (_) in
            //完成后恢复原状
            UIView.animate(withDuration: 0.25, animations: {
                for composeButton in self.composeButtons{
                    //透明度
                    composeButton.alpha = 1
                    composeButton.transform = CGAffineTransform.identity
                }
            }, completion: { (_) in
                //如果通过类名得到对应的 class 如果是系统的类 可以转成功 class 但是如果自定义的类无法成功
                //解决方法:对应的字符串的类前面需要加上命名空间 , 格式:命名空间.类名
                //字符串
                let className = "douYuShow.PJComposeViewController"
//                guard let className = button.composeModel?.classname else{
//                    return
//                }
                //通过字符串得到对应的 class
                guard let classType = NSClassFromString(className) as? UIViewController.Type else{
                    return
                }
                //通过 class 进行实例化对应的类对象
                let vc = classType.init()
                //通过模态方式弹出控制器
                self.target?.present(PJBaseNavController(rootViewController: vc), animated: true, completion: {
                    self.removeFromSuperview()
                })
            })
            
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


