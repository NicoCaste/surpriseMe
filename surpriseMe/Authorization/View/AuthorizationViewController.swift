//
//  AuthorizationViewController.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController, AuthorizationViewProtocol, WKNavigationDelegate {
    var completionHandler: ((Bool) -> Void)?
    var presenter: AuthorizationPresenterProtocol?
    var webView: WKWebView?
      
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        guard let webView = webView else { return }
        webView.frame = view.bounds
    }
    
    func configView() {
        guard let presenter =  presenter else { return }
        guard let url = presenter.getURL() else { return }
        webView = presenter.webView()
        guard let webView = webView else { return }
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let presenter = presenter else { return }
        guard let url = webView.url else { return }
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code"})?.value else {return }
        webView.isHidden = true
        presenter.exchangeCodeForToken(code: code)
    }
    
    //MARK: - AuthorizationViewProtocol
    func dismissLoading() {
    }
    
    func endEditing() {
    }
    
    func onError(res: String, resTitle: String, resMessage: String) {
    }
}
