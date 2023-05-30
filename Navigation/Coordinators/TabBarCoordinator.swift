//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    func switchToNextFlow()
}

final class TabBarCoordinator {
    
    
    //MARK: - Private Properties
    
    private let currentUser: User
    
    private weak var parentCoordinator: MainCoordinatorParentProtocol?
    
    private var tabBarController: UITabBarController
    
    private var childCoordinators: [CoordinatorProtocol] = []
    
    
    //MARK: - Life Cycles
    
    init(tabBarController: UITabBarController, parentCoordinator: MainCoordinatorParentProtocol?, currentUser: User) {
        self.tabBarController = tabBarController
        self.parentCoordinator = parentCoordinator
        self.currentUser = currentUser
    }
    
    
    //MARK: - Private Methods
    
    private func addChildCoordinator(coordinator: CoordinatorProtocol) {
        guard !self.childCoordinators.contains(where: {$0 === coordinator}) else {return}
        self.childCoordinators.append(coordinator)
                
    }
    
    private func removeChildCoordinator(coordinator: CoordinatorProtocol) {
        self.childCoordinators.removeAll(where: {$0 === coordinator})
    }
}



//MARK: - CoordinatorProtocol

extension TabBarCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        
        let tabBarController = UITabBarController()
        let feedCoordinator = FeedCoordinator(navigationController: UINavigationController(), parentCoordinator: self)
        addChildCoordinator(coordinator: feedCoordinator)
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController(), parentCoordinator: self, currentUser: currentUser)
        addChildCoordinator(coordinator: profileCoordinator)
        let controllers = [
            feedCoordinator.start(),
            profileCoordinator.start()
        ]
        tabBarController.viewControllers = controllers
        self.tabBarController = tabBarController
        return self.tabBarController
        
    }
}



//MARK: - TabBarCoordinatorProtocol

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func switchToNextFlow() {
        parentCoordinator?.switchToNextFlow(from: self, currentUser: currentUser)
    }
    
    
}
