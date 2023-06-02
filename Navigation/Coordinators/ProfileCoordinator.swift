//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func pushPhotoViewController(photos: [UIImage])
    func pushSettingsViewController()
    func logoutProfile()
}

final class ProfileCoordinator {
    
    //MARK: - Private Properties
    
    private let currentUser: User
    
    private var navigationController: UINavigationController
    
    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    
    
    //MARK: - Life Cycle
    
    init(navigationController: UINavigationController, parentCoordinator: TabBarCoordinatorProtocol?, currentUser: User) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.currentUser = currentUser
    }
    
    
    //MARK: - Private Methods
    
    private func createProfile(currentUser: User) -> UIViewController {
        let data = Post.make()
        let viewModel = ProfileViewModel(data: data, currentUser: currentUser, coordinator: self)
        let profileViewController = ProfileViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: profileViewController)
        navController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        self.navigationController = navController
        return navigationController
    }
    
}



//MARK: - CoordinatorProtocol

extension ProfileCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let profileViewController = self.createProfile(currentUser: currentUser)
        return profileViewController
    }
    
}



//MARK: - ProfileCoordinatorProtocol

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    
    func pushPhotoViewController(photos: [UIImage]) {
        print("ok")
        let photoViewModel = PhotoViewModel()
        let photosViewController = PhotosViewController(viewModel: photoViewModel)
        photosViewController.title = "Profile Photo"
        navigationController.pushViewController(photosViewController, animated: true)
    }
    
    func pushSettingsViewController() {
        let settingsViewModel = SettingsViewModel(coordinator: self)
        let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
        settingsViewController.modalPresentationStyle = .pageSheet
        settingsViewController.modalTransitionStyle = .coverVertical
        settingsViewController.view.backgroundColor = .systemBackground
        navigationController.present(settingsViewController, animated: true)
    }
    
    
    func logoutProfile() {
        parentCoordinator?.switchToNextFlow()
    }
    
    
}
