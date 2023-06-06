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
    
    private var timer: Timer?
    private var timerIsActive = true
    
    
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
    
    private func createTimer() {
                
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            let alert = UIAlertController(title: "Где подписка?", message: "Необходимо приобрести подписку", preferredStyle: .alert)
            
            let alertBuy = UIAlertAction(title: "Купить", style: .default) { _ in
                self.timer?.invalidate()
                
            }
            let alertNo = UIAlertAction(title: "No", style: .cancel) { _ in
                self.createTimer()
            }
            
            alert.addAction(alertBuy)
            alert.addAction(alertNo)
            
            self.timer?.invalidate()
            self.tabBarController.present(alert, animated: true)
            
        }
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
        createTimer()
        return self.tabBarController
        
    }
}



//MARK: - TabBarCoordinatorProtocol

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func switchToNextFlow() {
        self.parentCoordinator?.switchToNextFlow(from: self, currentUser: self.currentUser)
    }
}
