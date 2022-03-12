//
//  HomeViewController.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    let  singInButton: UIButton = UIButton()
    weak var coordinator: MainAppCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        setSingInButton()
    }
    
    //MARK: -SetSingInButton
    func setSingInButton() {
        singInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(singInButton)
        singInButton.setTitle("Sing In", for: .normal)
        singInButton.addTarget(self, action: #selector(singIn), for: .touchUpInside)
        singInButton.backgroundColor = .green
        singInButton.layer.cornerRadius = 10
        singInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        singInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        singInButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        singInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    @objc func singIn() {
        coordinator?.goToAuthorization(completionHandler: { [weak self] success in
            if success {
                let viewController = TabBarModule.build()
                viewController.modalPresentationStyle = .fullScreen
                self?.present(viewController, animated: true )
            }
        })
    }
    
    func configViewController() {
        
    }
}
