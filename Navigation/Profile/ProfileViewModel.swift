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
//    func getTickets()
}

final class ProfileViewModel {
    
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
    
    init(data: [Post], currentUser: User, coordinator: ProfileCoordinatorProtocol) {
        self.data = data
        self.currentUser = currentUser
        self.coordinator = coordinator
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    
//    func getTickets() {
//        self.state = .loading
//        let test: [Int] = []
//        self.state = .loaded(tickets: test)
//    }
    
    func didTapPhotoCollection() {
        coordinator.pushPhotoViewController(photos: [])
    }

}
