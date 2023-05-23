//
//  FeedViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//

import UIKit

final class FeedViewController: UIViewController {
    
    private let feedModelService: FeedModelProtocol
       
    private lazy var checkGuessButton = CustomButton(title: "Проверка", titleColor: .white, buttonAction: pressedButton)

    private lazy var secretWordField = CustomTextField(placeholder: "enter word")
   
    
   
    init(feedModelService: FeedModelProtocol) {
        self.feedModelService = feedModelService
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(secretWordField)
        view.addSubview(checkGuessButton)
        setupConstrait()
      
    }
    
    private func pressedButton() {
        
        feedModelService.check(secretWordField.text) { result in
            switch result {
            case .success(_):
                print("слово ок")
                self.colorCheck(self.secretWordField, .green)
            case .failure(let error):
                switch error {
                case .noWord:
                    print("введи слово то")
                    self.colorCheck(self.secretWordField, .red)
                case .uncorrectWord:
                    print("Слово не правильное")
                    self.colorCheck(self.secretWordField, .red)
                }
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

