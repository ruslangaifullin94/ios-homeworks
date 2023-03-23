//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit

class ProfileViewController: UIViewController {
   
    private let titleButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cменить Title", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(pressButtonSetTitle), for: .touchUpInside)
        return button
    }()
    
    @objc private func pressButtonSetTitle() {
        let profileName = profileHeaderView.nameLabel.text
        if title == profileName {
            title = "Profile"
        } else {
            title = profileName
        }
    }
    
    var profileHeaderView: ProfileHeaderView  = {
        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
     //   headerView.backgroundColor = .systemRed
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemGray
        view.addSubview(profileHeaderView)
        view.addSubview(titleButton)
        setupView()
        
    }
    private func setupView() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
            profileHeaderView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            titleButton.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 0),
            titleButton.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: 0),
            titleButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    

}
