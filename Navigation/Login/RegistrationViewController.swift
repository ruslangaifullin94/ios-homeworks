//
//  RegistrationViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 14.05.2023.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    private lazy var enterLogin: UITextField = {
        let login  = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.placeholder = "Enter Your Login"
        login.leftViewMode = .always
        login.layer.borderColor = UIColor.systemGray.cgColor
        login.layer.borderWidth = 0.5
        login.layer.cornerRadius = 10.0
        login.textColor = .black
        login.font = .systemFont(ofSize: 16.0, weight: .regular)
        login.tintColor = UIColor(named: "MainColor")
        login.autocapitalizationType = .none
        login.backgroundColor = .systemGray6
        login.keyboardType = .default
        login.autocorrectionType = .no
        login.returnKeyType = .continue
        login.tag = 0
        login.delegate = self
        return login
    }()
    
    private lazy var enterName: UITextField = {
       let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: name.frame.height))
        name.placeholder = "Enter your Name"
        name.leftViewMode = .always
        name.layer.borderColor = UIColor.systemGray.cgColor
        name.layer.borderWidth = 0.5
        name.layer.cornerRadius = 10.0
        name.textColor = .black
        name.font = .systemFont(ofSize: 16.0, weight: .regular)
        name.tintColor = UIColor(named: "MainColor")
        name.autocapitalizationType = .none
        name.backgroundColor = .systemGray6
        name.keyboardType = .default
        name.autocorrectionType = .no
        name.returnKeyType = .continue
        name.tag = 1
        name.delegate = self
        return name
    }()
    
    private lazy var enterStatus: UITextField = {
       let status = UITextField()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: status.frame.height))
        status.placeholder = "Enter your status"
        status.leftViewMode = .always
        status.layer.borderColor = UIColor.systemGray.cgColor
        status.layer.borderWidth = 0.5
        status.layer.cornerRadius = 10.0
        status.textColor = .black
        status.font = .systemFont(ofSize: 16.0, weight: .regular)
        status.tintColor = UIColor(named: "MainColor")
        status.autocapitalizationType = .none
        status.backgroundColor = .systemGray6
        status.keyboardType = .default
        status.autocorrectionType = .no
        status.returnKeyType = .done
        status.tag = 2
        status.delegate = self
        return status
    }()
    
    private lazy var regButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save New Profile", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.alpha = 1
        button.addTarget(self, action: #selector(registration), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraits()
        
    }
    
    private func setupSubviews() {
        view.addSubview(enterLogin)
        view.addSubview(enterName)
        view.addSubview(enterStatus)
        view.addSubview(regButton)
    }

    private func setupConstraits() {
        NSLayoutConstraint.activate([
        
            enterLogin.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            enterLogin.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            enterLogin.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            enterLogin.heightAnchor.constraint(equalToConstant: 50),
            
            enterName.topAnchor.constraint(equalTo: enterLogin.bottomAnchor, constant: 16),
            enterName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            enterName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            enterName.heightAnchor.constraint(equalToConstant: 50),
            
            enterStatus.topAnchor.constraint(equalTo: enterName.bottomAnchor, constant: 16),
            enterStatus.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            enterStatus.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            enterStatus.heightAnchor.constraint(equalToConstant: 50),
            
            regButton.topAnchor.constraint(equalTo: enterStatus.bottomAnchor, constant: 16),
            regButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            regButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            regButton.heightAnchor.constraint(equalToConstant: 50),
            
        
        ])
    }
    
    @objc private func registration() {
        if (enterLogin.text != "") && (enterName.text != "") {
            var newProfile = User(userLogin: enterLogin.text!, userAvatar: UIImage(named: "cat"), userName: enterName.text!, userStatus: enterStatus.text!, password: enterLogin.text! + enterLogin.text!)
            if newProfile.userStatus == "" {
                newProfile.userStatus = "нет статуса"
            }
            userData.append(newProfile)
            self.dismiss(animated: true)
        } else {
            print("work")
            errorLogin(enterLogin)
            errorLogin(enterName)
            
        }
    }
   

}
extension RegistrationViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        
        switch textField.tag {
        case 0:
            enterName.becomeFirstResponder()
        case 1:
            enterStatus.becomeFirstResponder()
        case 2:
            self.view.endEditing(true)
            registration()
        default:
            self.view.endEditing(true)
        }
        return true
    }
    
}

extension RegistrationViewController {
    func errorLogin(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.red.cgColor
        UIView.animate(withDuration: 1.5, animations: {
            textField.layer.borderColor = UIColor.systemGray.cgColor
        }        )
       
    }
}

