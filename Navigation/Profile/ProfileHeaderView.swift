//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 08.03.2023.
//

import UIKit


final class ProfileHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    
    private var currentUser: User?
    
    weak var delegate: ProfileViewControllerDelegate?
    
    private var statusText: String = ""
    
    var pointPhoto: CGPoint?
    
     private let setProfileAvatar: UIImageView = {
        let profileAvatar = UIImageView(frame: CGRect(x: 16, y: 16, width: 120, height: 120))
        profileAvatar.layer.borderWidth = 3
        profileAvatar.layer.cornerRadius = 60
        profileAvatar.clipsToBounds = true
        profileAvatar.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        profileAvatar.isUserInteractionEnabled = true
        return profileAvatar
    }()
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.numberOfLines = 2
        label.textColor = .gray
        return label
    }()
    private lazy var enterStatus: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.font = .systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 15
        text.translatesAutoresizingMaskIntoConstraints = false
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: text.frame.height))
        text.leftViewMode = .always
        text.addTarget(self, action: #selector(setStatus(_:)), for: .editingChanged)
        text.keyboardType = .default
        text.autocorrectionType = .no
        text.returnKeyType = .done
        text.isHidden = true
        text.delegate = self
        return text
    }()
    private lazy var statusButton: CustomButton = {
        let button = CustomButton(title: "Установить статус", titleColor: .white, buttonAction: pressButton)
        button.isHidden = true
        return button
    }()
    
     lazy var backgroundPhoto: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
     lazy var closePhotoButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.isHidden = true
        button.alpha = 0
        button.addTarget(self, action: #selector(cancelAnimation), for: .touchUpInside)
        return button
    }()
   
    
    //MARK: - Public Metod
    
    func setupUser(_ user: User) {
        self.currentUser = user
        nameLabel.text = user.userName
        setProfileAvatar.image = user.userAvatar
        statusLabel.text = user.userStatus
        
    }
    
    //MARK: - Metods
    
    private func setupGestureRecognizer() {
        let tapGesturePhoto = UITapGestureRecognizer(target: self, action: #selector(didTapPhotoAlert))
        tapGesturePhoto.numberOfTapsRequired = 1
        setProfileAvatar.addGestureRecognizer(tapGesturePhoto)
        let tapGestureStatus = UITapGestureRecognizer(target: self, action: #selector(didTapStatusShow))
        tapGestureStatus.numberOfTapsRequired = 1
        statusLabel.addGestureRecognizer(tapGestureStatus)
        
    
    }
   
    @objc private func cancelAnimation() {
        delegate?.closePhoto(image: setProfileAvatar)
    }
    
    @objc private func didTapPhotoAlert() {
        print("tap complete")
        delegate?.presentAlert(image: setProfileAvatar)
    }
    
    @objc private func didTapStatusShow() {
        enterStatus.isHidden = false
        statusButton.isHidden = false
    }
    
    private func didTapSetButton() {
        self.endEditing(true)
        statusLabel.text = statusText
        enterStatus.text = nil
        if statusLabel.text == "" {
            statusLabel.text = "Нажми на меня для установки статуса"
        }
        enterStatus.isHidden = true
        statusButton.isHidden = true
    }
    
    @objc private func setStatus(_ textField: UITextField) {
        statusText = textField.text!
    }
    
    @objc private func pressButton() {
        didTapSetButton()
    }
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        addSubview(nameLabel)
        addSubview(statusButton)
        addSubview(statusLabel)
        addSubview(enterStatus)
       addSubview(backgroundPhoto)
        addSubview(setProfileAvatar)
        addSubview(closePhotoButton)
       
        
        NSLayoutConstraint.activate([
            
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 152),
            
            
            statusLabel.bottomAnchor.constraint(equalTo: enterStatus.topAnchor, constant: -10),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 166),
            
            enterStatus.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -17),
            enterStatus.heightAnchor.constraint(equalToConstant: 40),
            enterStatus.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            enterStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
           
            closePhotoButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            closePhotoButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
           
        ])
        
    }
}

//MARK: - Extensions

extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            didTapSetButton()
        return true
    }
}


