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
    lazy var saveFeelingArtistsButton: UIButton = UIButton()
    lazy var addNewArtistsLabel: UILabel = UILabel()
    
    var keyboardActive: Bool = false
    var lookingForNewFavorite: Bool = false
    var needReload: Bool = true
    var artistsAlreadyFavs: [Artist?] = []
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        key = FeelingCategories.getTitle(feeling: presenter?.feeling ?? .IWantALightsaber)
        title = key
        view.backgroundColor = .systemBackground
        setAddNewArtistsLabel()
        setNewArtistsTextField()
        setCreatePlayListButton()
        setTableView()
        configDismissBoard()
    }
    
    // MARK: - ConfigDismissBoard
    // It recognizes the swipe up or down and hides the keyboard
    func configDismissBoard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToUp(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToDown(_:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToLeftSwipe(_:)))

        upSwipe.direction = .up
        downSwipe.direction = .down
        leftSwipe.direction = .left
        
        upSwipe.delegate = self
        downSwipe.delegate = self
        leftSwipe.delegate = self
        
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(leftSwipe)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
           true
       }

    @objc func moveToUp(_ sender: UISwipeGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func moveToDown(_ sender: UISwipeGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func moveToLeftSwipe(_ sender: UISwipeGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - SetNewArtistsTextField
    func setNewArtistsTextField() {
        newArtistsTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        newArtistsTextField.font = UIFont(name: "Noto Sans Myanmar Bold", size: 14)
        newArtistsTextField.placeholder = " Artist"
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
        addNewArtistsLabel.text = "Add artists to create a new playlist"
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
        tableView.bottomAnchor.constraint(equalTo: saveFeelingArtistsButton.topAnchor, constant: -10).isActive = true
    }
    
    func setCreatePlayListButton() {
        saveFeelingArtistsButton.translatesAutoresizingMaskIntoConstraints = false
        saveFeelingArtistsButton.addTarget(self, action:  #selector(createPlayList), for: .touchUpInside)
        view.addSubview(saveFeelingArtistsButton)
        saveFeelingArtistsButton.setTitle("Create New Playlist", for: .normal)
        saveFeelingArtistsButton.layer.masksToBounds = true
        saveFeelingArtistsButton.layer.cornerRadius = 5
        saveFeelingArtistsButton.backgroundColor = .systemBlue
        guard let newFont = UIFont(name: "Noto Sans Myanmar Bold", size: 18) else { return }
        saveFeelingArtistsButton.titleLabel?.font = newFont
        
        saveFeelingArtistsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        saveFeelingArtistsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        saveFeelingArtistsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        saveFeelingArtistsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func createPlayList() {
        guard let feeling = presenter?.feeling else { return }
        presenter?.goToCreateList(feeling: feeling, artists: artistsAlreadyFavs)
    }
    
    func tableNeedtoBeReloaded(itIsNecesary: Bool ) {
        needReload = itIsNecesary
        tableView.reloadData()
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lookingForNewFavorite {
            self.tableView.allowsSelection = true
            guard let artistsCount = presenter?.artistsMatch?.count else { return 0 }
            return artistsCount
        } else {
            EditFeelingArtistsPresenter.getFavs(forKey: key, completion: { [weak self] artists in
                guard let self = self else { return }
                self.tableView.allowsSelection = false
                self.artistsAlreadyFavs = artists
                if self.needReload {
                    self.newArtistsTextField.text = ""
                    self.tableNeedtoBeReloaded(itIsNecesary: false)
                }
            })
            return artistsAlreadyFavs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurpriseMeTableViewCell") as? SurpriseMeTableViewCell
        guard let cell = cell else { return UITableViewCell()}
        if lookingForNewFavorite {
            if let matchArtistCount = presenter?.artistsMatch?.count {
                if indexPath.row < matchArtistCount {
                    guard let currentArtist = presenter?.artistsMatch?[indexPath.row] else { return UITableViewCell()}
                    cell.populate(image: currentArtist.artistImage, text: currentArtist.artist.name ?? "")
                }
            }
        } else {
            let imageUrl = artistsAlreadyFavs[indexPath.row]?.images?.first?.url ?? ""
//            cell.populate(imageUrl: imageUrl, text: artistsAlreadyFavs[indexPath.row]?.name ?? "")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentArtist = presenter?.artistsMatch?[indexPath.row] else { return }
        presenter?.setFavList(forKey: key, fav: currentArtist.artist, completion:{ [weak self] saveArtist in
            if saveArtist {
                self?.lookingForNewFavorite = false
                self?.tableNeedtoBeReloaded(itIsNecesary: true)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if lookingForNewFavorite {
            let actions: [UIContextualAction] = []
            return UISwipeActionsConfiguration(actions: actions)
        }
            let currentArtist = artistsAlreadyFavs[indexPath.row]
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {[weak self] _,_,_ in
                self?.presenter?.removeFav(forKey: self?.key ?? "", fav: currentArtist ?? Artist(), completion: {[weak self] artistsWasRemoved in
                    if artistsWasRemoved {
                        self?.newArtistsTextField.text = ""
                        self?.tableNeedtoBeReloaded(itIsNecesary: true)
                    }
                })
            })
            deleteAction.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
