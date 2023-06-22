//
//  MultimediaCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 20.06.2023.
//

import UIKit

protocol MultimediaCoordinatorProtocol: AnyObject {
    
}

final class MultimediaCoordinator {
    
    //MARK: - Private Properties
    
    private var navigationController: UINavigationController
    
    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    
    //MARK: - Init
    
    init(navigationController: UINavigationController, parentCoordinator: TabBarCoordinatorProtocol?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    
    private func createMultimedia() -> UIViewController {
        let multimediaService = MultimediaService()
        let multimediaViewModel = MultimediaViewModel(multimediaService: multimediaService)
        multimediaService.delegate = multimediaViewModel
        let multimediaViewController = MultimediaViewController(viewModel: multimediaViewModel)
        let navController = UINavigationController(rootViewController: multimediaViewController)
        navController.tabBarItem = UITabBarItem(title: "Мультимедиа", image: UIImage(systemName: "music.note.house"), tag: 2)
        self.navigationController = navController
        return navigationController
    }
    
    
}

extension MultimediaCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createMultimedia()
    }
}

extension MultimediaCoordinator: MultimediaCoordinatorProtocol {
    
}
