//
//  FeedViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit

class FeedViewController: UIViewController {
   
    private lazy var actionButtonOne: UIButton = {
        let button = UIButton()
               button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
               button.setTitle("Глянуть первый пост", for: .normal)
               button.setTitleColor(.white, for: .normal)
               button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var actionButtonTwo: UIButton = {
        let button = UIButton()
               button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
               button.setTitle("Глянуть второй пост", for: .normal)
               button.setTitleColor(.white, for: .normal)
               button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func pressedButton() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(actionButtonOne)
        stackView.addArrangedSubview(actionButtonTwo)
        
        return stackView
    }()
    
    private func setupConstrait() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        setupConstrait()
      
    }

}

