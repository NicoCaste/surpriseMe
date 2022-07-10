//
//  MyPlayListsViewController.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

class MyPlayListsViewController: UIViewController, MyPlaylistsViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView? = UITableView()
    var presenter: MyPlaylistsPresenterProtocol?
    var activityIndicator: UIActivityIndicatorView?
    var notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.addObserver(self, selector: #selector(showErrorView(_:)), name: NSNotification.Name.showErrorView, object: nil)
        title =  "myPlaylists".localized()
        view.backgroundColor = .systemBackground
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getPlaylists()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: NSNotification.Name.showErrorView, object: nil)
    }
    
    @objc func showErrorView(_ error: Notification) {
        guard let errorMessage = error.userInfo  else { return }
        let detailError = errorMessage["errorMessage"]
        let errorView = ErrorViewViewController()
        
        errorView.errorMessage = detailError as? ErrorMessage
        self.present(errorView, animated: true)
    }
    
    
    func setTableView() {
        guard let tableView = tableView else { return }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPlaylistTableViewCell.self, forCellReuseIdentifier: "MyPlaylistTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func setActivityIndicator() {
        tableView?.isHidden = true
        activityIndicator = UIActivityIndicatorView(style: .large)
        guard let activityIndicator = activityIndicator else { return }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.playlists.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPlaylistTableViewCell") as! MyPlaylistTableViewCell
        guard let playlistWithImage = presenter.playlists[indexPath.row] else { return UITableViewCell() }
        cell.populate(playlistWithImage: playlistWithImage)
        return cell

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {[weak self] _,_,_ in
            let playlist = self?.presenter?.playlists[indexPath.row]?.playlist
            let spotifyUri = playlist?.externalUrls?.spotify ?? ""
            let name = playlist?.name
            self?.presenter?.unfollowPlaylists(playListUri: spotifyUri, name: name ?? "")
            self?.tableView?.reloadData()
        })
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
