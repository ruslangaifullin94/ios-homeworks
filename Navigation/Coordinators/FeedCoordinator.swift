//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

final class FeedCoordinator {
    
    
    //MARK: - Private Properties
    
    private var navigationController: UINavigationController
    
    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    
    
    //MARK: - Life Cycles
    
    init(navigationController: UINavigationController, parentCoordinator: TabBarCoordinatorProtocol?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
}



//MARK: - CoordinatorProtocol

extension FeedCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let feedModel = FeedModel()
        let feedViewModel = FeedViewModel(feedModelService: feedModel)
        let feedViewController = FeedViewController(feedViewModel: feedViewModel)
        let navController = UINavigationController(rootViewController: feedViewController)
        navController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext"), tag: 0)
        self.navigationController = navController
        return navigationController
    }
    
}
