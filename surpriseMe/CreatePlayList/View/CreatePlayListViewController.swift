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
        notificationCenter.addObserver(self, selector: #selector(showErrorView(_:)), name: NSNotification.Name.showErrorView, object: nil)
        notificationCenter.addObserver(self, selector: #selector(setReloadView), name: NSNotification.Name.recibeData, object: nil)
        notificationCenter.addObserver(self, selector: #selector(withoutData), name: NSNotification.Name.withoutData, object: nil)
        title = "newPlayList".localized()
        view.backgroundColor = .systemBackground
        setActivityIndicator()
        presenter?.getTrackRecommendation()
        setCreatePlayListButton()
        setTableView()
        reloadList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: NSNotification.Name.recibeData, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.withoutData, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.showErrorView, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.post(name: NSNotification.Name.playBackPaused, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.showErrorView, object: ErrorMessage.self)
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
    
    // MARK: - ObserverSelector
    @objc func showErrorView(_ error: Notification) {
        guard let errorMessage = error.userInfo  else { return }
        let detailError = errorMessage["errorMessage"]
        let errorView = ErrorViewViewController()
        
        errorView.errorMessage = detailError as? ErrorMessage
        self.present(errorView, animated: true)
    }
    
    @objc func withoutData() {
        perform(#selector(closeAll), with: nil, afterDelay: 5)
    }
    
    @objc func closeAll() {
        self.dismiss(animated: true, completion: {
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
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
        activityIndicator = nil
        tableView.isHidden = true
        createPlayListButton.isHidden = true
        activityIndicator = UIActivityIndicatorView(style: .large)
        guard let activityIndicator = activityIndicator else { return }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func setReloadView() {
        tableView.reloadData()
        activityIndicator?.removeFromSuperview()
        tableView.isHidden = false
        createPlayListButton.isHidden = false
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

