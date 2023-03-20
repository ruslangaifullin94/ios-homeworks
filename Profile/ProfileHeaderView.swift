//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 08.03.2023.
//

import UIKit

final class ProfileHeaderView: UIView {
    private var statusText: String = ""
    private let setProfileAvatar: UIImageView = {
        let profileAvatar = UIImageView()
        profileAvatar.image = UIImage(named: "cat")
        profileAvatar.layer.borderWidth = 3
        profileAvatar.layer.cornerRadius = 60
        profileAvatar.clipsToBounds = true
        profileAvatar.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        profileAvatar.translatesAutoresizingMaskIntoConstraints = false
        return profileAvatar
    }()
     public let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cat Lucy"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите статус ниже"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    private let enterStatus: UITextField = {
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
        return text
    }()
    private let statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.7
        button.setTitle("Установить статус", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    
    
    @objc private func setStatus(_ textField: UITextField) {
        statusText = textField.text!
    }
   @objc private func pressButton() {
       statusLabel.text = statusText
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
        addSubview(setProfileAvatar)
        addSubview(nameLabel)
        addSubview(statusButton)
        addSubview(statusLabel)
        addSubview(enterStatus)
        
        NSLayoutConstraint.activate([
            setProfileAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            setProfileAvatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            setProfileAvatar.widthAnchor.constraint(equalToConstant: 120),
            setProfileAvatar.heightAnchor.constraint(equalToConstant: 120),
       
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            //nameLabel.leftAnchor.constraint(equalTo: setProfileAvatar.rightAnchor, constant: 16),
           // nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
        
            
            statusLabel.bottomAnchor.constraint(equalTo: enterStatus.topAnchor, constant: -10),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.topAnchor.constraint(equalTo: setProfileAvatar.bottomAnchor, constant: 30),
            
            enterStatus.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -17),
            enterStatus.heightAnchor.constraint(equalToConstant: 40),
            enterStatus.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            enterStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
       
    }
    

}
