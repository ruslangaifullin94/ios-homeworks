//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

protocol MainCoordinatorParentProtocol: AnyObject{
    func switchToNextFlow(from currentCoodinator: CoordinatorProtocol, currentUser: User)
}

final class MainCoordinator {
    
    //MARK: - Private Properties
    
    private var rootViewController: UIViewController
    
    private var childCoordinators: [CoordinatorProtocol] = []
    
    
    //MARK: - Life Cycles
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    
    //MARK: - Private Methods
    
    private func setLoginCoordinator() -> CoordinatorProtocol {
        let loginCoordinator = LoginCoordinator(navigationController: UINavigationController(), parentCoordinator: self)
        return loginCoordinator
    }
    private func setTabBarCoordinator(currentUser: User) -> CoordinatorProtocol {
        let tabBarCoordinator = TabBarCoordinator(tabBarController: UITabBarController(), parentCoordinator: self, currentUser: currentUser)
        return tabBarCoordinator
    }
    
    private func addChildCoordinator(coordinator: CoordinatorProtocol) {
        guard !self.childCoordinators.contains(where: {$0 === coordinator}) else {return}
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
   private func setFlow(to newViewController: UIViewController) {
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.frame
        rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: rootViewController)
    }
    
    private func switchFlow(to newViewController: UIViewController) {
        rootViewController.children[0].willMove(toParent: nil)
        rootViewController.children[0].navigationController?.isNavigationBarHidden = true
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.bounds
        
        rootViewController.transition(
            from: rootViewController.children[0],
            to: newViewController,
            duration: 0.6,
            options: [.transitionFlipFromRight],
            animations: {}
        ) {_ in
            self.rootViewController.children[0].removeFromParent()
            newViewController.didMove(toParent: self.rootViewController)
        }
    }
    
    private func switchCoordinators(from oldCoordinator: CoordinatorProtocol, to newCoordinator: CoordinatorProtocol) {
        addChildCoordinator(coordinator: newCoordinator)
        switchFlow(to: newCoordinator.start())
        removeChildCoordinator(coordinator: oldCoordinator)
    }
    
    
    
}



//MARK: - CoordinatorProtocol

extension MainCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        
        var coordinator: CoordinatorProtocol
        
        coordinator = setLoginCoordinator()
        addChildCoordinator(coordinator: coordinator)
        setFlow(to: coordinator.start())
        return rootViewController
    }
    
}



//MARK: - MainCoordinatorParentProtocol

extension MainCoordinator: MainCoordinatorParentProtocol {
    
    
    func switchToNextFlow(from currentCoodinator: CoordinatorProtocol, currentUser: User) {
        switch currentCoodinator {

        case let oldCoordinator as LoginCoordinator:
            let newCoordinator = self.setTabBarCoordinator(currentUser: currentUser)
            self.switchCoordinators(from: oldCoordinator, to: newCoordinator)

        case let oldCoordinator as TabBarCoordinator:
            let newCoordinator = self.setLoginCoordinator()
            self.switchCoordinators(from: oldCoordinator, to: newCoordinator)

        default:
            print("Ошибка! func switchToNextFlow in MainCoordinator")
        }
    }
    
}
