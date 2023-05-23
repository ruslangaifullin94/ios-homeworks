//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

final class TabBarCoordinator {
    private var childCoordinators: [CoordinatorProtocol] = []
    
    private func addChildCoordinator(coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(coordinator: CoordinatorProtocol) {

    }
}

extension TabBarCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        
        let tabBarController = UITabBarController()
        let feedCoordinator = FeedCoordinator()
        addChildCoordinator(coordinator: feedCoordinator)
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        addChildCoordinator(coordinator: profileCoordinator)
        let controllers = [
            feedCoordinator.start(),
            profileCoordinator.start()
        ]
        tabBarController.viewControllers = controllers
        return tabBarController
        
    }
    
    
}
