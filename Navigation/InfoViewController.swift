//
//  InfoViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit

final class InfoViewController: UIViewController, UIAlertViewDelegate {
    private lazy var alertButton: UIButton = {
            let button = UIButton()
            button.setTitle("Show Alert", for: .normal)
            button.addTarget(self, action: #selector(didTapAlertButton), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    
    @objc private func didTapAlertButton() {
            let alert = UIAlertController(title: "Hello", message: "Are you ok?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Yes", style: .default) {
                UIAlertAction in
                NSLog("All right")
            }
            let cancelAction = UIAlertAction(title: "No", style: .default) {
                UIAlertAction in
                NSLog("Needs to be improved")
            }
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    
    fileprivate func setupConstraints(){
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            alertButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            alertButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            alertButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            alertButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        view.addSubview(alertButton)
        setupConstraints()
    }
    
}
