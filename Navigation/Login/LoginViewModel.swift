//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 25.05.2023.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    #if DEBUG
    var userService: TestUserService { get }

    #else
    var userService: CurrentUserService { get }
    #endif
    
    var stateChanger: ((LoginViewModel.State) -> Void)? { get set}

    func loginCheck(_ login: String?,_ password: String?)
}



final class LoginViewModel {
    #if DEBUG
    internal var userService: TestUserService

    #else
    internal var userService: CurrentUserService

    #endif
    internal let coordinator: ProfileCoordinatorProtocol

    var loginDelegate: LoginViewControllerDelegate?
    
    enum State {
        case logout
        case login
        case unCorrectPass
        case unCorrectLogin
        
    }
    
    var stateChanger: ((State) -> Void)?
    
    var state: State = .logout {
        didSet {
            self.stateChanger?(state)
        }
    }
    #if DEBUG
    init(userService: TestUserService, coordinator: ProfileCoordinatorProtocol) {
        self.userService = userService
        self.coordinator = coordinator
    }

    #else
    init(userService: CurrentUserService, coordinator: ProfileCoordinatorProtocol) {
        self.userService = userService
        self.coordinator = coordinator
    }
    #endif

    
    
    
}

extension LoginViewModel: LoginViewModelProtocol {
    
    func loginCheck(_ login: String?,_ password: String?) {
        guard let loginDelegate = self.loginDelegate else {return}
        switch self.userService.logInToUser(login) {
        case .success(let user):
            
            switch loginDelegate.check(user.userLogin, password!) {
                
            case .failure(let error):
                switch error {
                case .wrongLogin:
                    print("login off")
                    state = .unCorrectLogin
                case .wrongPass:
                    print("pass off")
                    state = .unCorrectPass
                }
            case .success(_):
                coordinator.pushProfileViewController(currentUser: user)
                state = .login
            }

        case .failure(let error):
            switch error {
            case .wrongLogin:
                state = .unCorrectLogin
            }
        }
    }
}
