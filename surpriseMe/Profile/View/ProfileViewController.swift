//
//  UserConfigViewController.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

class ProfileViewController: UIViewController, ProfileViewProtocol, UITableViewDelegate, UITableViewDataSource {
    var presenter: ProfilePresenterProtocol?
    var tableView: UITableView = UITableView()
    lazy var logOutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Profile"
        view.backgroundColor = .systemBackground
        configLogOutButton()
        configTableView()
        getProfile()
    }
    
    func getProfile() {
        guard let presenter = presenter else { return }
        presenter.getuserData()
    }
    
    //MARK: - ConfigLogOutButton
    @objc func logOut() {
        print("POR QUYE TE FUISTE MABEL!")
    }
    
    //MARK: - ConfigLogOutButton
    func configLogOutButton() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logOutButton)
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        logOutButton.backgroundColor = .systemBlue
        logOutButton.layer.masksToBounds = true
        logOutButton.layer.cornerRadius = 8
        logOutButton.titleLabel?.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    //MARK: - ConfigTableView
    func configTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        tableView.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: "ProfileImageTableViewCell")
        tableView.register(ProfileDataTableViewCell.self, forCellReuseIdentifier: "ProfileDataTableViewCell")
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -10).isActive = true
    }
    
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return UserConfigTrakingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let presenter = presenter else { return "" }
        return presenter.sectionName(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let profile = presenter?.profile else { return UITableViewCell() }
        let datacell = tableView.dequeueReusableCell(withIdentifier: "ProfileDataTableViewCell") as! ProfileDataTableViewCell
        switch indexPath.section {
        case UserConfigTrakingSection.Image.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageTableViewCell") as! ProfileImageTableViewCell
            cell.delegate = presenter as? ProfileImageDelegate
            var url = ""
            if let images = profile.images.first {
                url = images?.url ?? ""
            }
            cell.populate(urlImage: url, image: presenter?.currentImage, id: indexPath.row)
                return cell
        case UserConfigTrakingSection.name.rawValue:
            datacell.populate(text: profile.displayName ?? "")
        case UserConfigTrakingSection.email.rawValue:
            datacell.populate(text: profile.email ?? "")
        case UserConfigTrakingSection.id.rawValue:
            datacell.populate(text: profile.id ?? "" )
        case UserConfigTrakingSection.plan.rawValue:
            datacell.populate(text: profile.product ?? "")
        default:
            return UITableViewCell()
        }
        return datacell
    }
}
