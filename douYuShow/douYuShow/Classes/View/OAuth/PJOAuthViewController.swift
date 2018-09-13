//
//  PJOAuthViewController.swift
//  douYuShow
//
//  Created by jie peng on 2018/9/11.
//  Copyright © 2018年 pengjie. All rights reserved.
//

import UIKit
import SVProgressHUD

class PJOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    override func loadView() {
        view = webView
        webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏关闭按钮
        self.view.isOpaque = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭",target: self, action: #selector(close))
        //设置后门..
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "快捷登录",target: self, action: #selector(defaultAccount))
        loadOAuthPage()
    }
    
    @objc private func defaultAccount(){
        let jsString = "document.getElementById('userId').value = 'pengjie1108@hotmail.com' , document.getElementById('passwd').value = 'pengjie328118'"
        webView.stringByEvaluatingJavaScript(from: jsString)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    private func loadOAuthPage(){
        //传递请求页面参数
        let urlString = "https://api.weibo.com/oauth2/authorize?" + "client_id=" + client_id + "&redirect_uri=" + redirect_uri
        //1.url
        let url = URL(string: urlString)
        //2.req
        guard let u = url else {
            return
        }
        let req = URLRequest(url: u)
        //3.webview
        webView.loadRequest(req)
    }
    
    @objc private func close(){
        self.dismiss(animated: true, completion: nil)
    }

}

extension PJOAuthViewController: UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
        SVProgressHUD.showError(withStatus: "网页加载错误")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //1.获取节在页面的 urlString
        let urlString = request.url?.absoluteString ?? ""
        //2.判断 urlString 是否包含 code
        let flag = "code="
        //3.截取 code
        if urlString.contains(flag){
            let query = request.url?.query ?? ""
            let code = query.substring(from: flag.endIndex)

//            loadAccessToken(code: code)
            //获取 code 后开始调用方法
            PJUserAccountViewModel.shared.loadAccessToken(code: code, finished: {(success) in
                if !success {
                    //失败
                    SVProgressHUD.showError(withStatus: "返回值错误")
                    return
                }
                //成功
                print("登录成功")
                UIApplication.shared.keyWindow?.rootViewController = PJWelcomeViewController()
            })
            //成功之后不显示后面页面
            return false
        }
        return true
    }
    
    
}
