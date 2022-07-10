//
//  EditFeelingArtistsViewController.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 19/02/2022.
//

import UIKit

class EditFeelingArtistsViewController: UIViewController, EditFeelingArtistsViewProtocol, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    var presenter: EditFeelingArtistsPresenterProtocol?
    var newArtistsTextField: UITextField = UITextField()
    var tableView: UITableView = UITableView()
    lazy var createPlayListButton: UIButton = UIButton()
    lazy var addNewArtistsLabel: UILabel = UILabel()
    
    var keyboardActive: Bool = false
    var lookingForNewFavorite: Bool = false
    var needReload: Bool = true
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDismissBoard()
        key = FeelingCategories.getTitle(feeling: presenter?.feeling ?? .IWantALightsaber)
        title = key
        view.backgroundColor = .systemBackground
        presenter?.getFavs(forKey: key)
        setAddNewArtistsLabel()
        setNewArtistsTextField()
        setCreatePlayListButton()
        setTableView()
    }

    //MARK: - SetNewArtistsTextField
    func setNewArtistsTextField() {
        newArtistsTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        newArtistsTextField.font = UIFont(name: "Noto Sans Myanmar Bold", size: 14)
        newArtistsTextField.placeholder = "artist".localized()
        newArtistsTextField.backgroundColor = .systemFill
        setNewArtistIcon()
        newArtistsTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newArtistsTextField)
        
        newArtistsTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        newArtistsTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -5).isActive = true
        newArtistsTextField.topAnchor.constraint(equalTo: addNewArtistsLabel.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
        newArtistsTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        newArtistsTextField.layer.cornerRadius = 5
        
    }
    
    //MARK: - SetAddNewArtistsLabel
    func setAddNewArtistsLabel() {
        addNewArtistsLabel.font = UIFont(name: "Noto Sans Myanmar Bold", size: 18)
        addNewArtistsLabel.text = "addartists".localized()
        addNewArtistsLabel.textAlignment = .left
        addNewArtistsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addNewArtistsLabel)
        
        addNewArtistsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        addNewArtistsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -20).isActive = true
        addNewArtistsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
    }
    
    func setNewArtistIcon() {
        let magnifyInGlass: UIImageView = UIImageView()
        magnifyInGlass.image = UIImage(systemName: "magnifyingglass")
        newArtistsTextField.leftView = magnifyInGlass
        newArtistsTextField.leftViewMode = UITextField.ViewMode.always
        newArtistsTextField.leftViewMode = .always
        magnifyInGlass.tintColor = .black
        magnifyInGlass.heightAnchor.constraint(equalToConstant: 30).isActive = true
        magnifyInGlass.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField ) {
        guard let textFieldtext = textField.text else {return}
        presenter?.findArtist(artist: textFieldtext)
    }
    
    func setTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(SurpriseMeTableViewCell.self, forCellReuseIdentifier: "SurpriseMeTableViewCell")
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: newArtistsTextField.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: createPlayListButton.topAnchor, constant: -10).isActive = true
    }
    
    func setCreatePlayListButton() {
        createPlayListButton.translatesAutoresizingMaskIntoConstraints = false
        createPlayListButton.addTarget(self, action:  #selector(createPlayList), for: .touchUpInside)
        view.addSubview(createPlayListButton)
        createPlayListButton.setTitle("createNewPlaylist".localized(), for: .normal)
        createPlayListButton.layer.masksToBounds = true
        createPlayListButton.layer.cornerRadius = 5
        createPlayListButton.backgroundColor = .systemBlue
        guard let newFont = UIFont(name: "Noto Sans Myanmar Bold", size: 18) else { return }
        createPlayListButton.titleLabel?.font = newFont
        
        createPlayListButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        createPlayListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        createPlayListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        createPlayListButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func createPlayList() {
        guard let feeling = presenter?.feeling else { return }
        if !lookingForNewFavorite {
            presenter?.goToCreateList(feeling: feeling, artists: presenter?.artistsMatch ?? [])
        }
    }
    
    func tableNeedtoBeReloaded(itIsNecesary: Bool ) {
        needReload = itIsNecesary
        tableView.reloadData()
    }
    
    private func showCreatePlayListButton() {
        guard let artists = presenter?.artistsMatch?.count else { return }
        if !lookingForNewFavorite {
            createPlayListButton.isHidden = (artists > 0) ? false : true
        }
    }
    
    private func resetSearch() {
        lookingForNewFavorite = false
        newArtistsTextField.text = ""
        presenter?.getFavs(forKey: key)
        tableNeedtoBeReloaded(itIsNecesary: true)
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.allowsSelection = lookingForNewFavorite
        guard let artists = presenter?.artistsMatch?.count else { return 0 }
        showCreatePlayListButton()
        return artists
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurpriseMeTableViewCell") as? SurpriseMeTableViewCell
        guard let cell = cell else { return UITableViewCell()}
        if let matchArtistCount = presenter?.artistsMatch?.count {
            if indexPath.row < matchArtistCount {
                guard let currentArtist = presenter?.artistsMatch?[indexPath.row] else { return UITableViewCell()}
                cell.populate(image: currentArtist.artistImage, text: currentArtist.artist.name ?? "")
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let matchArtistCount = presenter?.artistsMatch?.count {
            if indexPath.row < matchArtistCount {
                guard let currentArtist = presenter?.artistsMatch?[indexPath.row] else { return }
                NotificationCenter.default.post(name: NSNotification.Name.reloadArtistsMatch, object: nil)
                presenter?.setFavList(forKey: key, fav: currentArtist.artist, completion:{ [weak self] saveArtist in
                    if saveArtist {
                        self?.resetSearch()
                    }
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if lookingForNewFavorite {
            let actions: [UIContextualAction] = []
            return UISwipeActionsConfiguration(actions: actions)
        }
        let currentArtist = presenter?.artistsMatch?[indexPath.row].artist
        let deleteAction = UIContextualAction(style: .destructive, title: "delete".localized(), handler: {[weak self] _,_,_ in
                self?.presenter?.removeFav(forKey: self?.key ?? "", fav: currentArtist ?? Artist(), completion: {[weak self] artistsWasRemoved in
                    if artistsWasRemoved {
                        self?.resetSearch()
                    }
                })
            })
            deleteAction.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
