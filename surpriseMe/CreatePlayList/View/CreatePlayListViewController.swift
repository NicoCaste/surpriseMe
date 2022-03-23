//
//  CreatePlayListViewController.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import UIKit

class CreatePlayListViewController: UIViewController, CreatePlayListViewProtocol, UITableViewDelegate, UITableViewDataSource {
    var presenter: CreatePlayListPresenterProtocol?
    var tableView: UITableView = UITableView()
    lazy var createPlayListButton: UIButton = UIButton()
    var activityIndicator: UIActivityIndicatorView?
    private var notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New PlayList - \(FeelingCategories.getTitle(feeling: presenter?.feeling ?? .IWantALightsaber))"
        view.backgroundColor = .systemBackground
        setActivityIndicator()
        presenter?.getTrackRecommendation()
        setCreatePlayListButton()
        setTableView()
        reloadList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.post(name: NSNotification.Name.playBackPaused, object: nil)
    }
    
    func reloadList() {
        let navBarbutton = UIBarButtonItem.init(title: "", style: .done, target: self, action: #selector(giveMeAnother))
        navBarbutton.image = UIImage(systemName: "arrow.triangle.2.circlepath.circle.fill")
        navBarbutton.width = 80
        self.navigationItem.rightBarButtonItem = navBarbutton
    }
    
    @objc func giveMeAnother() {
        notificationCenter.post(name: NSNotification.Name.playBackPaused, object: nil)
        guard let presenter = presenter else { return }
        setActivityIndicator()
        presenter.getTrackRecommendation()
    }
    
    //MARK: SetCreatePlayListButton
    func setCreatePlayListButton() {
        createPlayListButton.translatesAutoresizingMaskIntoConstraints = false
        createPlayListButton.addTarget(self, action:  #selector(createPlayList), for: .touchUpInside)
        view.addSubview(createPlayListButton)
        createPlayListButton.setTitle("Create a New PlayList", for: .normal)
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
        guard let presenter = presenter else { return }
        presenter.createPlayList()
    }
    
    //MARK: SetCreatePlayListButton
    func setTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrackListTableViewCell.self, forCellReuseIdentifier: "TrackListTableViewCell")
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: createPlayListButton.topAnchor, constant: -10).isActive = true
    }
    
    func setActivityIndicator() {
        tableView.isHidden = true 
        activityIndicator = UIActivityIndicatorView(style: .large)
        guard let activityIndicator = activityIndicator else { return }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.trackList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackListTableViewCell") as! TrackListTableViewCell
        if indexPath.row < presenter.trackList.count {
          let track = presenter.trackList[indexPath.row]
            cell.populate(trackWithImage: track, index: indexPath.row)
            cell.delegate = presenter
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {[weak self] _,_,_ in
            self?.presenter?.trackList.remove(at: indexPath.row)
            self?.tableView.reloadData()
        })
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


extension Notification.Name {
    static var playBackPaused: Notification.Name {
        return .init(rawValue: "AudioPlayer.playbackPaused")
    }
}
