//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

final class MainCoordinator {
    private var childCoordinators: [CoordinatorProtocol] = []
    
    private func addChildCoordinator(coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(coordinator: CoordinatorProtocol) {

    }
}

extension MainCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        
        let tabBarCoordinator = TabBarCoordinator()
        addChildCoordinator(coordinator: tabBarCoordinator)
        
        return tabBarCoordinator.start()
    }
    
}

