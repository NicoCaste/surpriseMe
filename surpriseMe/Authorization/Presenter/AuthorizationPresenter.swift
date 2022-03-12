//
//  AuthorizationPresenter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import Foundation
import WebKit

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    var view: AuthorizationViewProtocol?
    var interactor: AuthorizationInteractorProtocol?
    var router: AuthorizationRouterProtocol?
    var url: URL?
    
    func webView () -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }
    
    func getURL() -> URL? {
        guard let interactor = interactor else { return URL(string: "") }
        return interactor.singInUrl()
    }
    
    func dismissView() {
        guard let router = router else { return }
        router.goToRootView()
    }
    
    func exchangeCodeForToken(code: String) {
        guard let interactor = interactor else { return }
        interactor.exchangeCodeForToken(code: code, completion: { [weak self ] success in
            DispatchQueue.main.async {
                guard let view = self?.view else { return }
                self?.dismissView()
                view.completionHandler?(success)
            }
        })
    }
}
