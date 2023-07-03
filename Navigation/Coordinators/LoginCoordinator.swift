//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 26.05.2023.
//

import UIKit


protocol LoginCoordinatorProtocol: AnyObject {
    func switchToNextFlow(currentUser: User)
}


final class LoginCoordinator {
    
    //MARK: - Private Methods
    
    private var childCoordinators: [CoordinatorProtocol] = []
    
    private var navigationController: UINavigationController
    
    weak var parentCoordinator: MainCoordinatorParentProtocol?

    
    //MARK: - Life Cycles
    
    init(navigationController: UINavigationController, parentCoordinator: MainCoordinatorParentProtocol) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    
    //MARK: - Private Methods
    
    private func createLogin() -> UIViewController {
        
        #if DEBUG
        let userService = TestUserService()
        #else
        let userService = CurrentUserService()
        #endif
        let checkerService = CheckerService()
        let loginViewControllerDelegate = MyLoginFactory().makeLoginInspector()
        let loginViewModel = LoginViewModel(userService: userService, coordinator: self, chekerService: checkerService)
        let loginViewController = LogInViewController(loginViewModel: loginViewModel)
        loginViewModel.loginDelegate = loginViewControllerDelegate
        let navController = UINavigationController(rootViewController: loginViewController)
        self.navigationController = navController
        return navigationController
    }
    
}



//MARK: - CoordinatorProtocol

extension LoginCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let loginViewController = createLogin()
        return loginViewController
    }
    
}



//MARK: - LoginCoordinatorProtocol

extension LoginCoordinator: LoginCoordinatorProtocol {
    func switchToNextFlow(currentUser: User) {
        parentCoordinator?.switchToNextFlow(from: self, currentUser: currentUser)
    }

}
