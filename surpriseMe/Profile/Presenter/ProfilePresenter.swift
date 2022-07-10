//
//  ProfilePresenter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import UIKit

enum UserConfigTrakingSection: Int, CaseIterable {
    case Image
    case name
    case email
    case id
    case plan
}

class ProfilePresenter: ProfilePresenterProtocol, ProfileImageDelegate {
    
    var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    var profile: Profile?
    var currentImage: UIImage?
    
    func getuserData() {
        interactor?.getuserData(completion: {[weak self] profileData in
            switch profileData.result {
            case .success:
                let profilDataValue = profileData.value
                self?.profile = profilDataValue
                self?.view?.tableView.reloadData()
                
                guard let profile = self?.profile else {return}
                self?.interactor?.cacheClient(result: profile)
            case .failure:
                ShowErrorManager.showErrorView(title: "sorry".localized(), description: "errorUserInfo".localized())
            }
            
        })
    }
    
    func imageAllreadyLoad(id: Int, url: String) {
        DispatchQueue.main.async {
            ApiCaller.shared.getImage(url: url, completion: {[weak self] userImage in
                guard let userImage = userImage else { return }
                self?.currentImage = userImage
                let indexPath = IndexPath(item: id, section: 0)
                self?.view?.tableView.reloadRows(at: [indexPath], with: .none)
            })
        }
    }
    
    func sectionName(section: Int) -> String {
        switch section {
        case UserConfigTrakingSection.name.rawValue:
            return "name".localized()
        case UserConfigTrakingSection.email.rawValue:
            return "email".localized()
        case UserConfigTrakingSection.id.rawValue:
            return "userId".localized()
        case UserConfigTrakingSection.plan.rawValue:
            return "plan".localized()
        default:
            return ""
        }
    }
}
