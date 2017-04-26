//
//  InAppWebViewController.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/23.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class InAppWebViewController: UIViewController{
    
    var urlString = "https://www.baidu.com/"
    private let webView = WKWebView(frame: UIScreen.main.bounds)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addWebView()
        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        navigationController?.title = "RESULT DETAILS"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = ThemeColor
        
        let titleButton = UIButton()
        titleButton.setTitle("RESULT DETAILS", for: .normal)
        titleButton.setTitleColor(UIColor.white, for: .normal)
        titleButton.sizeToFit()
        titleButton.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        navigationItem.titleView = titleButton
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItem = refresh
    }
    
    private func addWebView() {
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        if let url = URL(string: urlString){
            webView.load(URLRequest(url: url))
        }
    }
    
    @objc func refreshTapped() {
        webView.reload()
    }
    
    @objc func btnClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension InAppWebViewController: WKNavigationDelegate,WKUIDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("1111")
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("2222")
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("333")
    }
}
