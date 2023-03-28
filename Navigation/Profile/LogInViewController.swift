//
//  LogInViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 22.03.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginData = "test"
    private let passData = "123"
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
       let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var login: UITextField = {
        let login  = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.placeholder = "Email or Phone"
        login.leftViewMode = .always
        login.layer.borderColor = UIColor.systemGray.cgColor
        login.layer.borderWidth = 0.5
        login.layer.cornerRadius = 10.0
        login.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
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
    
    
    
    private lazy var password: UITextField = {
        let password  = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.placeholder = "Password"
        password.leftViewMode = .always
        password.layer.borderColor = UIColor.systemGray.cgColor
        password.layer.borderWidth = 0.5
        password.layer.cornerRadius = 10.0
        password.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        password.textColor = .black
        password.font = .systemFont(ofSize: 16.0, weight: .regular)
        password.tintColor = UIColor(named: "MainColor")
        password.autocapitalizationType = .none
        password.backgroundColor = .systemGray6
        password.keyboardType = .default
        password.autocorrectionType = .no
        password.returnKeyType = .done
        password.isSecureTextEntry = true
        password.tag = 1
        password.delegate = self
        
        return password
    }()
    
    private let logInButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.alpha = 1
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    private lazy var logInStack: UIStackView = { [unowned self] in
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.clipsToBounds = true
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.addArrangedSubview(login)
        stack.addArrangedSubview(password)
        return stack
    }()
    
    //MARK: - LifeCycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupContentOfScrollView()
        setupConstraits()
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeybordsObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
//MARK: - Metods
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
           let keyboardRectangle = keyboardFrame.cgRectValue
           let keyboardHeight = keyboardRectangle.height
            let logInButtonBottomPointY = logInButton.frame.origin.y + logInButton.frame.height + contentView.frame.origin.y
           let keyboardOriginY = scrollView.frame.height - keyboardHeight
           let yOffset = keyboardOriginY < logInButtonBottomPointY ? logInButtonBottomPointY - keyboardOriginY : 0
            scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
    @objc private func logIn() {
//        if (login.text == loginData) && (password.text == passData) {
//            if login.isSelected {
//                login.alpha = 0.8
//            } else if login.isHighlighted {
//                login.alpha = 0.8
//            }
//            let profileViewController = ProfileViewController()
//            self.navigationController?.pushViewController(profileViewController, animated: true)
//        }
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    
    private func setupConstraits() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            logInStack.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            logInStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            logInStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            logInStack.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: logInStack.bottomAnchor, constant: 16),
            logInButton.rightAnchor.constraint(equalTo: logInStack.rightAnchor, constant: 0),
            logInButton.leftAnchor.constraint(equalTo: logInStack.leftAnchor, constant: 0),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
                    
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
                ])
        contentView.subviews.last?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    private func setupContentOfScrollView() {
        contentView.addSubview(logo)
        contentView.addSubview(logInStack)
        contentView.addSubview(logInButton)
    }
    private func setupKeybordsObservers() {
        let notificationCenter = NotificationCenter.default
       
        notificationCenter.addObserver(
                    self,
                    selector: #selector(self.willShowKeyboard(_:)),
                    name: UIResponder.keyboardWillShowNotification,
                    object: nil
                )
                
        notificationCenter.addObserver(
                    self,
                    selector: #selector(self.willHideKeyboard(_:)),
                    name: UIResponder.keyboardWillHideNotification,
                    object: nil
                )
        
    }
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.removeObserver(self)
    }
}
//MARK: - Extensions

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            password.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
            logIn()
        }
        return true
    }
}
