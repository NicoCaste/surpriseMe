//
//  ProfileEntity.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import UIKit
import Alamofire

protocol ProfileViewProtocol {
    var tableView: UITableView { get }
}

protocol ProfileInteractorProtocol {
    func getuserData(completion: @escaping((DataResponse<Profile, AFError>) -> Void))
    func cacheClient(result: Profile)
}

protocol ProfilePresenterProtocol {
    var profile: Profile? { get }
    var currentImage: UIImage? { get }
    func sectionName(section: Int) -> String
    func getuserData()
}

protocol ProfileRouterProtocol {}
