//
//  Common.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/11.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

//通知名称
let SWITCHROOTVIEWCONTROLLERNOTI = "SWITCHROOTVIEWCONTROLLERNOTI"

let client_id = "3271022753"
let redirect_uri = "www.baidu.com"
let client_secret = "8caa648cd61b3a7c19eb67290ecc9830"

let ScreenWidth: CGFloat = UIScreen.main.bounds.width
let ScreenHeight: CGFloat = UIScreen.main.bounds.height

func randomColor() -> UIColor{
    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
}

