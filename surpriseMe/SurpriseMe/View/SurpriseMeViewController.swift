//
//  SurpriseMeViewController.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit
import CoreNFC

class SurpriseMeViewController: UIViewController, SurpriseMeViewProtocol, UITableViewDelegate, UITableViewDataSource {
    var presenter: SurpriseMePresenterProtocol?
    
    lazy var surpriseMeLabel: UILabel = UILabel()
    lazy var tableView = UITableView()
    var currentFeling: SurpriseMeFeeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "surpriseMe".localized()
        view.backgroundColor = .systemBackground
        setSurpriseMeLabel()
        setTableView()
    }
    
    //MARK: - SetSurpriseMeLabel
    func setSurpriseMeLabel() {
        surpriseMeLabel.font = UIFont(name: "Noto Sans Myanmar semi Bold", size: 15)
        surpriseMeLabel.text = "howDoYouFeel".localized()
        surpriseMeLabel.textAlignment = .left
        surpriseMeLabel.numberOfLines = 0
        surpriseMeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(surpriseMeLabel)
        
        surpriseMeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        surpriseMeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -20).isActive = true
        surpriseMeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true 
    }
    
    //MARK: - SetTableView
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SurpriseMeTableViewCell.self, forCellReuseIdentifier: "SurpriseMeTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: surpriseMeLabel.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = self.presenter else { return 0 }
        return presenter.getFeelings().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = self.presenter else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurpriseMeTableViewCell") as! SurpriseMeTableViewCell
        cell.populate(feeling: presenter.getFeelings()[indexPath.row] )
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = self.presenter else { return }
        presenter.goToCreatePlayList(feeling: presenter.getFeelings()[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "edit".localized(), handler: {[weak self] _,_,_ in
            guard let presenter = self?.presenter else { return }
            presenter.goToEditArtists(feeling: presenter.getFeelings()[indexPath.row])
        })
        editAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [editAction])
    }

}
