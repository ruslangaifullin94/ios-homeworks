//
//  LogInViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 22.03.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
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
    
    private lazy var login: UITextField = { [unowned self] in
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
        
        login.delegate = self
        return login
    }()
    
    private lazy var password: UITextField = { [unowned self] in
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
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
            let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
            scrollView.contentInset.bottom += keyboardHeight ?? 0.0
        }
        
    @objc func willHideKeyboard(_ notification: NSNotification) {
            scrollView.contentInset.bottom = 0.0
        }
    
    @objc private func logIn() {
      
        if login.isSelected {
            login.alpha = 0.8
        } else if login.isHighlighted {
            login.alpha = 0.8
        }
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    private func setupLogIn() {
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
            
            
            
        ])
    }
    
    private func setupConstraits() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
                    scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
                    scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
                    
                    contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                    contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                ])
    }
    
    private func setupContentOfScrollView() {
        contentView.addSubview(logo)
        contentView.addSubview(logInStack)
        contentView.addSubview(logInButton)
        setupLogIn()
        
        contentView.subviews.last?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupConstraits()
        setupContentOfScrollView()
        
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

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
