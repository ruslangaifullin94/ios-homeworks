//
//  PostViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit
import StorageService

class PostViewController: UIViewController {
    
    
    private var data: Post? = nil
    
    
    func update(model: Post) {
        data = model
        
       // navigationItem.title = model.author
        
    }
    
    
//    var post = Post(title: "Новенький пост")
//
//    private func settingView() {
//        self.view.backgroundColor = .systemYellow
//        self.navigationItem.title = post.title
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoButtonPress(_:)))
//
//    }
//    @objc private func infoButtonPress(_ sender: UIButton) {
//        let infoViewController = InfoViewController()
//        infoViewController.modalTransitionStyle = .flipHorizontal
//        infoViewController.modalPresentationStyle = .pageSheet
//        present(infoViewController, animated: true)
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       settingView()
//    }
//
}
