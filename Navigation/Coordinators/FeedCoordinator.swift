//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

final class FeedCoordinator {
    
}

extension FeedCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let feedModel = FeedModel()
        let feedViewController = FeedViewController(feedModelService: feedModel)
        let navController = UINavigationController(rootViewController: feedViewController)
        navController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext"), tag: 0)
        return navController
    }
    
    
    
}
