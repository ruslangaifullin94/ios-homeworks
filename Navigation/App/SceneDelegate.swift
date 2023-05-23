//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var mainCoordinator: CoordinatorProtocol?

//    func createFeedViewController() -> UINavigationController {
//        let feedModel = FeedModel()
//        let feedViewController = FeedViewController(feedModelService: feedModel)
//        feedViewController.title = "Лента"
//        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext"), tag: 0)
//        return UINavigationController(rootViewController: feedViewController)
//    }
//
//    func createLogInViewController() -> UINavigationController {
//
//        #if DEBUG
//        let userService = TestUserService()
//        #else
//        let userService = CurrentUserService()
//        #endif
//
//        let loginViewControllerDelegate = MyLoginFactory().makeLoginInspector()
//        let loginViewController = LogInViewController(userService: userService)
//        loginViewController.title = "Профиль"
//        loginViewController.loginDelegate = loginViewControllerDelegate
//        loginViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
//        return UINavigationController(rootViewController: loginViewController)
//
//    }
//    func createTabBarController() -> UITabBarController {
//        let tabBarController = UITabBarController()
//        let controllers = [createFeedViewController(),createLogInViewController()]
//        tabBarController.viewControllers = controllers
//        return tabBarController
//    }
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let mainCoordinator = MainCoordinator()
        window.rootViewController = mainCoordinator.start()
        window.makeKeyAndVisible()
        createPhotosArray()
        self.window = window
        self.mainCoordinator = mainCoordinator
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

