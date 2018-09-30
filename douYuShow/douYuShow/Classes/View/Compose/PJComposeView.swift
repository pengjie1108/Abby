//
//  PJComposeView.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/30.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

class PJComposeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = randomColor()
    }
    
}

extension PJComposeView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeFromSuperview()
    }
}
