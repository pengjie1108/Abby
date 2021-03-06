//
//  AppDelegate.swift
//  douYuShow
//
//  Created by pengjie on 2016/11/20.
//  Copyright © 2016年 pengjie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //手动创建 window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = setupRootViewController()
        window?.makeKeyAndVisible()
        //注册通知来切换根控制器
        NotificationCenter.default.addObserver(self, selector: #selector(switchRootViewController), name: NSNotification.Name(rawValue: SWITCHROOTVIEWCONTROLLERNOTI), object: nil)
        return true
    }
    
    /*
     判断用户是否登录
        -没登录
           -PJMainVc(访客视图界面)
             -OAuthVc(用户名和密码登录)
             -PJWelcomeVc(欢迎界面)
             -PJMainVC(首页)
        -如果登录了
            -PJWelcomeVc(欢迎界面)
            -PJMainVC(首页)
     */
    @objc private func switchRootViewController(noti: Notification){
        if let _ = noti.object {
             //object 为空,跳转到主控制器
            window?.rootViewController = PJMainTabBarController()
        }else{
            //object 跳转到欢迎界面
            window?.rootViewController = PJWelcomeViewController()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func setupRootViewController() -> UIViewController {

        return PJUserAccountViewModel.shared.userLogin ? PJWelcomeViewController() : PJMainTabBarController ()
    }

}

