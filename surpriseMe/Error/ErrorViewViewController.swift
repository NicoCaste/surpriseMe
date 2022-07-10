//
//  ErrorViewViewController.swift
//  surpriseMe
//
//  Created by nicolas castello on 10/07/2022.
//

import UIKit

struct ErrorMessage {
    var title: String
    var description: String
}

class ErrorViewViewController: UIViewController, CAAnimationDelegate {
    let color1: CGColor = UIColor(red: 209/255, green: 107/255, blue: 165/255, alpha: 1).cgColor
    let color2: CGColor = UIColor(red: 134/255, green: 168/255, blue: 231/255, alpha: 1).cgColor
    let color3: CGColor = UIColor(red: 95/255, green: 251/255, blue: 241/255, alpha: 1).cgColor
    
    lazy var cardView: UIView = UIView()
    lazy var closeButton: UIButton = UIButton()
    lazy var errorImage: UIImageView = UIImageView()
    lazy var errorTitle: UILabel = UILabel()
    lazy var errorDescription: UILabel = UILabel()
    lazy var errorMessage: ErrorMessage? = nil
    let gradient: CAGradientLayer = CAGradientLayer()
    var gradientColorSet: [[CGColor]] = []
    var colorIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configErrorImage()
        configCardView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubviewToFront(errorImage)
        setupGradient()
        animateGradient()
        configErrorTitle()
        configErrorDescription()
        configCloseButton()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animateGradient()
        }
    }
    
    func setupGradient(){
        gradientColorSet = [
            [color1, color2],
            [color2, color3],
            [color3, color1]
        ]
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientColorSet[colorIndex]
        
        self.cardView.layer.addSublayer(gradient)
    }
    
    func animateGradient() {
        gradient.colors = gradientColorSet[colorIndex]
        
        let gradientAnimation = CABasicAnimation(keyPath: "colors")
        gradientAnimation.delegate = self
        gradientAnimation.duration = 1.0
        
        updateColorIndex()
        gradientAnimation.toValue = gradientColorSet[colorIndex]
        
        gradientAnimation.fillMode = .forwards
        gradientAnimation.isRemovedOnCompletion = false
        
        gradient.add(gradientAnimation, forKey: "colors")
    }
    
    func updateColorIndex(){
        if colorIndex < gradientColorSet.count - 1 {
            colorIndex += 1
        } else {
            colorIndex = 0
        }
    }
    
    func configCardView() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            cardView.heightAnchor.constraint(equalToConstant: (self.view.bounds.height / 2))
        ])
    }
    
    func configErrorImage() {
        errorImage.image = UIImage(named: "jimmyHendrix")
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorImage)
        
        NSLayoutConstraint.activate([
            errorImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.bounds.height / 4)),
            errorImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            errorImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            errorImage.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func configErrorTitle() {
        errorTitle.text = errorMessage?.title ?? "" 
        errorTitle.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(errorTitle)
        errorTitle.font = UIFont(name: "Noto Sans Myanmar Bold", size: 20)
        errorTitle.textAlignment = .center
        errorTitle.textColor = .black
        errorTitle.numberOfLines = 0
        NSLayoutConstraint.activate([
            errorTitle.topAnchor.constraint(equalTo: cardView.centerYAnchor, constant: -100),
            errorTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
            errorTitle.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5)
        ])
    }
    
    func configErrorDescription() {
        errorDescription.text = errorMessage?.description ?? ""
        errorDescription.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(errorDescription)
        errorDescription.font = UIFont(name: "Noto Sans Myanmar Bold", size: 18)
        errorDescription.textAlignment = .center
        errorDescription.textColor = .black
        errorDescription.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            errorDescription.topAnchor.constraint(equalTo: errorTitle.bottomAnchor, constant: 10),
            errorDescription.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
            errorDescription.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5)
        ])
    }
    
    //MARK: SetCreatePlayListButton
    func configCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action:  #selector(dismissView), for: .touchUpInside)
        cardView.addSubview(closeButton)
        closeButton.setTitle("Close", for: .normal)
        closeButton.layer.masksToBounds = true
        closeButton.layer.cornerRadius = 5
        closeButton.backgroundColor = .systemGray
        guard let newFont = UIFont(name: "Noto Sans Myanmar Bold", size: 18) else { return }
        closeButton.titleLabel?.font = newFont
            
        NSLayoutConstraint.activate([
            closeButton.bottomAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            closeButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}
