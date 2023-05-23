//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

protocol ProfileCoordinatorProtocol {
    func pushProfileViewController(currentUser: User)
    func pushPhotoViewController(photos: [UIImage])
}

final class ProfileCoordinator {
    
    private var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func createLogin() -> UIViewController {
        
        #if DEBUG
        let userService = TestUserService()
        #else
        let userService = CurrentUserService()
        #endif
        
        let loginViewControllerDelegate = MyLoginFactory().makeLoginInspector()
        let loginViewController = LogInViewController(userService: userService, coordinator: self)
        loginViewController.loginDelegate = loginViewControllerDelegate
        let navController = UINavigationController(rootViewController: loginViewController)
        navController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        self.navigationController = navController
        return navController
    }
    
    private func createProfile(currentUser: User) -> UIViewController {
        let data = Post.make()
        let viewModel = ProfileViewModel(data: data, currentUser: currentUser, coordinator: self)
        let profileViewController = ProfileViewController(viewModel: viewModel)
        return profileViewController
    }
    
}

extension ProfileCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let loginViewController = createLogin()
        return loginViewController
    }
    
    
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    
    func pushProfileViewController(currentUser: User) {
        let profileViewController = self.createProfile(currentUser: currentUser)
        self.navigationController.pushViewController(profileViewController, animated: true)

    }
    
    func pushPhotoViewController(photos: [UIImage]) {
        let photosViewController = PhotosViewController()
        photosViewController.title = "Profile Photo"
        self.navigationController.pushViewController(photosViewController, animated: true)
    }
    
    
}
