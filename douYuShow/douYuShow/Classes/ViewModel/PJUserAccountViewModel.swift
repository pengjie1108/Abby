//
//  PJUserAccountViewModel.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/3.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit

private let userAccount_Path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")

class PJUserAccountViewModel: NSObject {

    //全局只有一个登陆用户
    static let shared: PJUserAccountViewModel = PJUserAccountViewModel()
    
    //创建用户模型
    var account: PJUserAccount?
    
    //token
    var accessToken: String?{
        //已经登录的状态
        
        //未登录的状态
        return nil
    }
    
    override init() {
        super.init()
        self.account = self.loadUserAccount()
    }
    
    //获取
    func loadUserAccount() -> PJUserAccount? {
        let account = NSKeyedUnarchiver.unarchiveObject(withFile: userAccount_Path)
        //获取到账户信息
        if let acc = account as? PJUserAccount {
            return acc
        }
        //获取不到数据
        return nil
    }
    
    //用户是否登录
    var userLogin: Bool{
        if account?.access_token != nil && isExpires == false{
            return true
        }
        return false
    }

    //用户token 是否过期
    var isExpires: Bool{
        //判断token 是否过期
        if account?.expires_date?.compare(Date()) == .orderedDescending {
            return false
        }
        return true
    }
    
    
    
}
