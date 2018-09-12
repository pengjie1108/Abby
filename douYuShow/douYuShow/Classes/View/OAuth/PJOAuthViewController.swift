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
            print("code----------:"+code)
            loadAccessToken(code: code)
            //成功之后不显示后面页面
            return false
        }
        return true
    }
    
    //请求用户授权token
    private func loadAccessToken(code: String) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let para = ["client_id" : client_id,
                    "client_secret" : client_secret,
                    "grant_type" : "authorization_code",
                    "code" : code,
                    "redirect_uri" : redirect_uri]
        
        PJNetworkTools.shared.request(method: .POST, urlString: urlString, parameters: para) { (res, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "世界上最遥远的距离就是没有网络")
                return
            }
            self.loadUserInfo(res as! [String : Any])
            print(res!)
        }
    }
    
    private func loadUserInfo (_ dict: [String: Any]) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        let token = dict["access_token"]
        let uid = dict["uid"]!
        
        let para = ["access_token": token,
                    "uid": uid];
        PJNetworkTools.shared.request(method: .GET, urlString: urlString, parameters: para) { (res, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "世界上最遥远的距离就是没有网络")
                return
            }
        }
    }
}
