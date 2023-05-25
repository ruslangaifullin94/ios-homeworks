//
//  FeedViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit

final class FeedViewController: UIViewController {
    
    private let feedViewModel: FeedViewModelProtocol
       
    private lazy var checkGuessButton = CustomButton(title: "Проверка", titleColor: .white, buttonAction: pressedButton)

    private lazy var secretWordField = CustomTextField(placeholder: "enter word")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(secretWordField)
        view.addSubview(checkGuessButton)
        setupConstrait()
        bindModel()
    }
    
    init (feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func pressedButton() {
        feedViewModel.didTapCheckButton(secretWordField.text)
    }
    
    private func bindModel() {
        feedViewModel.stateChanger = { [weak self] state in
            guard let self = self else {return}
           switch state {
           case .waiting:
               ()
           case .true:
               self.colorCheck(self.secretWordField, .green)
           case .false:
               self.colorCheck(self.secretWordField, .red)
           }
        }
    }
    
   private func colorCheck(_ textField: UITextField, _ color: UIColor) {
        textField.backgroundColor = color
        UIView.animate(withDuration: 0.5, delay: 0.3) {
            textField.backgroundColor = .systemGray6
        }
    }
    
    private func setupConstrait() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            secretWordField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            secretWordField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            secretWordField.heightAnchor.constraint(equalToConstant: 50),
            secretWordField.widthAnchor.constraint(equalToConstant: 120),
            
            checkGuessButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: secretWordField.bottomAnchor, constant: 20),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    

}

