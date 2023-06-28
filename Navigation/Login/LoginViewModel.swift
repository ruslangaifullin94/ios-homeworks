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
    func passGenerate()
}

final class LoginViewModel {
    
    
    //MARK: - Properties
    
    #if DEBUG
    internal var userService: TestUserService

    #else
    internal var userService: CurrentUserService

    #endif
    internal let coordinator: LoginCoordinatorProtocol

    var loginDelegate: LoginViewControllerDelegate?
    
    enum State {
        case logout
        case login
        case passGenerateStart
        case passGenerateFinish(pass: String)
        case wrong(text: String)
        
    }
    
    var stateChanger: ((State) -> Void)?
    
    var state: State = .logout {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    
    //MARK: - Life Cycles
    
    #if DEBUG
    init(userService: TestUserService, coordinator: LoginCoordinator) {
        self.userService = userService
        self.coordinator = coordinator
    }

    #else
    init(userService: CurrentUserService, coordinator: LoginCoordinator) {
        self.userService = userService
        self.coordinator = coordinator
    }
    #endif

}



//MARK: - LoginViewModelProtocol

extension LoginViewModel: LoginViewModelProtocol {
    
    func loginCheck(_ login: String?,_ password: String?) {
        guard let loginDelegate = self.loginDelegate else {return}

        switch self.userService.logInToUser(login) {
        case .success(let user):
            
//            switch loginDelegate.check(user.userLogin, password!) {
//
//            case .failure(let error):
//                state = .wrong(text: error.errorDescription)
//            case .success(_):
//                coordinator.switchToNextFlow(currentUser: user)
//                state = .login
//            }
            
            do {
                try loginDelegate.checkNew(user.userLogin, password!)
                coordinator.switchToNextFlow(currentUser: user)
                state = .login
            } catch CheckerError.wrongLogin {
                state = .wrong(text: CheckerError.wrongLogin.errorDescription)
            } catch CheckerError.wrongPass {
                state = .wrong(text: CheckerError.wrongPass.errorDescription)
            } catch {
                state = .wrong(text: "неизвестная ошибка")
            }
                
            

        case .failure(let error):
            switch error {
            case .wrongLogin:
                state =  .wrong(text: error.errorDescription)
            }
        }
    }
    
    func passGenerate() {
        
        state = .passGenerateStart
        let start = Date()
         GeneratePassword.shared.generatePassword(length: 40000) { newPass in
             
             let group = DispatchGroup()
             var resultPass = ""
            for char in newPass {
                group.enter()
                 BruteForce.shared.bruteForcePublic(passwordToUnlock: String(char)) { letter in
                     resultPass.append(letter)
                     group.leave()
                 }
             }
             let workItem = DispatchWorkItem { [self] in
                 let finish = Date()
                 let timer = finish.timeIntervalSince(start)
                 print(timer)
                 state = .passGenerateFinish(pass: resultPass)
             }
             group.notify(queue: DispatchQueue.main, work: workItem)
         }
    }
}
