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
            button.backgroundColor = .black
            button.setTitle("Show Alert", for: .normal)
            button.addTarget(self, action: #selector(didTapAlertButton), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
   
    
    private lazy var labelTitle: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var labelOrbitalPeriod: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelOrbitalPeriod)

        return stack
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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(alertButton)
        view.addSubview(stackView)
        setupConstraints()
        
            NetworkService.getRequest(completion: { titleText in
                DispatchQueue.main.async {
                    self.labelTitle.text = titleText
                }
            })
        
        NetworkService.getOrbitalPeriod { orbitalPeriod in
            DispatchQueue.main.async {
                self.labelOrbitalPeriod.text = orbitalPeriod
            }
        }
        
    }
    
    
    private func setupConstraints(){
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            alertButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            alertButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            alertButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            alertButton.heightAnchor.constraint(equalToConstant: 40.0),
            
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            stackView.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 40.0),
        ])
    }
    
}
