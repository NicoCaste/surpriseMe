//
//  AuthorizationEntity.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import Foundation
import WebKit

protocol AuthorizationViewProtocol {
    func dismissLoading()
    var presenter: AuthorizationPresenterProtocol? { get set }
    func endEditing()
    func onError(res: String, resTitle: String, resMessage: String)
    var completionHandler: ((Bool) -> Void)? { get set }
}

protocol AuthorizationInteractorProtocol {
    var presenter: AuthorizationPresenterProtocol? { get set }
    func exchangeCodeForToken(code: String, completion: @escaping((Bool) -> Void))
    func singInUrl () -> URL? 
}

protocol AuthorizationPresenterProtocol {
    func getURL() -> URL? 
    func webView() -> WKWebView
    func exchangeCodeForToken(code: String)
    func dismissView()
}

protocol AuthorizationRouterProtocol {
    func goToRootView() 
}




