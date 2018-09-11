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
        
        loadOAuthPage()
    }
    
    private func loadOAuthPage(){
        //传递请求页面参数
        let urlString = "https://api.weibo.com/oauth2/authorize?" + "client_id=" + "1028311281" + "&redirect_uri=" + "www.baidu.com"
        print(urlString)
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
        SVProgressHUD.showError(withStatus: "网页加载错误")
    }
}
