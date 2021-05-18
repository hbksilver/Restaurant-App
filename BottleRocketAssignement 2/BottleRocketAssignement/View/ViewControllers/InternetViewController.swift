//
//  InternetViewController.swift
//  BottleRocketAssignement
//
//  Created by Hassan Baraka on 4/13/21.
//

import UIKit
import WebKit

class InternetViewController: UIViewController {
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        return webView
    }()
    var webViewRefreshButton:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar()
        self.loadWebPage()
        view.addSubview(webView)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        guard let url = URL(string: "https://www.bottlerocketstudios.com") else { return }
        webView.load(URLRequest(url: url))
    }
    private func configureNavBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        let webBackButton = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .plain, target: self, action: #selector(self.webBackButtonSelected))
        webBackButton.tintColor = .white
        
        let button = UIButton()
        button.setImage(UIImage(named:"ic_webRefresh"), for: .normal)
        button.addTarget(self, action: #selector(self.webRefreshButtonSelected), for: .touchUpInside)
        let webRefreshButton = UIBarButtonItem(customView: button)
        webRefreshButton.tintColor = .white
        self.webViewRefreshButton = button
        
        let webForwardButton = UIBarButtonItem(image: UIImage(named: "ic_webForward"), style: .plain, target: self, action: #selector(self.webForwardButtonSelected))
        webForwardButton.tintColor = .white
        
        self.navigationItem.setLeftBarButtonItems([webBackButton,webRefreshButton,webForwardButton], animated: false)
    }
    func configureUI(){
        view.backgroundColor = .systemRed
    }
    func loadWebPage(){
        guard let url = URL(string: "https://www.bottlerocketstudios.com") else { return }
        self.webView.load(URLRequest(url: url))
    }
    @objc func webBackButtonSelected(){
        self.webView.goBack()
    }
    @objc func webForwardButtonSelected(){
        self.webView.goForward()
    }
    @objc func webRefreshButtonSelected(){
        if self.webView.isLoading{
            self.webView.stopLoading()
            self.webViewRefreshButton?.setImage(UIImage(named: "ic_webRefresh"), for: .normal)
        }else{
            self.webView.reload()
            self.webViewRefreshButton?.setImage(UIImage(named: "ic_close"), for: .normal)
        }
    }
}
extension InternetViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webViewRefreshButton?.setImage(UIImage(named: "ic_webRefresh"), for: .normal)
    }
}
    
