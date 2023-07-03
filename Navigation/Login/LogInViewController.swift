//
//  LogInViewController.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 22.03.2023.
//

import UIKit



final class LogInViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let loginViewModel: LoginViewModelProtocol
    
    private lazy var logInButton = CustomButton(title: "Log In", titleColor: .white, buttonAction: logIn)
    private lazy var brutForceButton = CustomButton(title: "Sign In", titleColor: .white, buttonAction: signin)
    
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
    
    private lazy var login: CustomTextField = {
        let login  = CustomTextField(placeholder: "Email or Phone")
//        login.text = "cat"
        login.delegate = self
        login.tag = 0
        login.returnKeyType = .continue
        return login
    }()
    
    private lazy var password: CustomTextField = {
        let password  = CustomTextField(placeholder: "Password")
//        password.text = "catcat"
        password.returnKeyType = .done
        password.isSecureTextEntry = true
        password.tag = 1
        password.delegate = self
        return password
    }()
        
    private lazy var logInStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.clipsToBounds = true
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.layer.cornerRadius = 10.0
        stack.addArrangedSubview(login)
        stack.addArrangedSubview(password)
        return stack
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    //MARK: - LifeCycle
    
    init(loginViewModel: LoginViewModel) {
            self.loginViewModel = loginViewModel
            super.init(nibName: nil, bundle: nil)
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupContentOfScrollView()
        setupConstraits()
        bindLoginModel()
        if login.text == "" || password.text == "" {
            logInButton.isEnabled = false
        }
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
    
//MARK: - Private Methods
    
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
  
    private func logIn() {
        loginViewModel.loginCheck(login.text, password.text)
    }
    
    private func generatePassword() {

        loginViewModel.passGenerate()
       
        
    }
    private func signin() {
        let checkerService = CheckerService()
        let registrationViewController = RegistrationViewController(checkerService: checkerService)
        registrationViewController.modalTransitionStyle = .coverVertical
        registrationViewController.modalPresentationStyle = .formSheet
        present(registrationViewController, animated: true)
    }
    
    private func bindLoginModel() {
        loginViewModel.stateChanger = { [weak self] state in
            guard let self = self else {return}
            switch state {
            case .logout:
                ()
            case .login:
                ()
            case .wrong(let text):
                self.presentAlert(text)
            case .passGenerateStart:
                indicator.startAnimating()
                brutForceButton.isEnabled = false
            case .passGenerateFinish(let resultPass):
                password.text = resultPass
                password.isSecureTextEntry = false
                brutForceButton.isEnabled = true
                indicator.stopAnimating()
            }
        }
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
            
            indicator.centerYAnchor.constraint(equalTo: password.centerYAnchor),
            indicator.rightAnchor.constraint(equalTo: password.rightAnchor, constant: -5),
            indicator.widthAnchor.constraint(equalToConstant: 10),
            indicator.heightAnchor.constraint(equalToConstant: 10),
                                             
            brutForceButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            brutForceButton.rightAnchor.constraint(equalTo: logInButton.rightAnchor, constant: 0),
            brutForceButton.leftAnchor.constraint(equalTo: logInButton.leftAnchor, constant: 0),
            brutForceButton.heightAnchor.constraint(equalToConstant: 50),
            
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
        contentView.addSubview(indicator)
        contentView.addSubview(logInButton)
        contentView.addSubview(brutForceButton)
        
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



//MARK: - UITextFieldDelegate

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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == "" {
            logInButton.isEnabled = false
        } else {
            logInButton.isEnabled = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
    }
}


//MARK: - LogInViewController

extension LogInViewController {
    func presentAlert(_ error: String) {
        let optionMenu = UIAlertController(title: "Ошибка", message: "\(error)", preferredStyle: .alert)
        let optionAction = UIAlertAction(title: "Ok", style: .default)
        optionMenu.addAction(optionAction)
        self.navigationController?.present(optionMenu, animated: true)
    }
    
}

