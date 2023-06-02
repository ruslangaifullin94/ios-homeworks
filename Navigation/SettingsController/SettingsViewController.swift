//
//  SettingsViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 29.05.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let viewModel: SettingsViewModelProtocol

    private lazy var logoutButton = CustomButton(title: "Logout", titleColor: .white, buttonAction: logout)
    
    
    //MARK: - LifeCycles
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraits()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Privtae Methods
    
    private func setupView() {
        view.backgroundColor = .systemRed
        view.addSubview(logoutButton)
    }
    
    private func logout() {
        viewModel.logoutProfile()
        dismiss(animated: true)
    }
    
    private func setupConstraits() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 120),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
