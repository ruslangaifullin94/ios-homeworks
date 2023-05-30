//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import Foundation

protocol ProfileViewModelProtocol: AnyObject {
    
    var data: [Post] {get}
    var currentUser: User { get }
    var stateChanger: ((ProfileViewModel.State) -> Void)? {get set}
    func didTapPhotoCollection()
    func pushSettingsController()
}

final class ProfileViewModel {
    
    //MARK: - Private Properties
    
    private let coordinator: ProfileCoordinatorProtocol
    var data: [Post]
    let currentUser: User
    
    enum State {
        case loading
        case loaded
    }
        
    var stateChanger: ((State) -> Void)?
    
    private var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    
    //MARK: - Life Cycles
    
    init(data: [Post], currentUser: User, coordinator: ProfileCoordinatorProtocol) {
        self.data = data
        self.currentUser = currentUser
        self.coordinator = coordinator
    }
}



//MARK: - ProfileViewModelProtocol

extension ProfileViewModel: ProfileViewModelProtocol {
    
    func didTapPhotoCollection() {
        coordinator.pushPhotoViewController(photos: [])
        state = .loaded
    }
    
    func pushSettingsController() {
        coordinator.pushSettingsViewController()
    }

}
