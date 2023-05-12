//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 08.03.2023.
//

import UIKit
import SnapKit

final class ProfileHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    weak var delegate: ProfileViewControllerDelegate?
    private var statusText: String = ""
    var pointPhoto: CGPoint?
     private let setProfileAvatar: UIImageView = {
        let profileAvatar = UIImageView(frame: CGRect(x: 16, y: 16, width: 120, height: 120))
        profileAvatar.image = UIImage(named: "cat")
        profileAvatar.layer.borderWidth = 3
        profileAvatar.layer.cornerRadius = 60
        profileAvatar.clipsToBounds = true
        profileAvatar.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        profileAvatar.isUserInteractionEnabled = true
        return profileAvatar
    }()
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cat Lucy"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажми на меня для установки статуса"
        label.font = .systemFont(ofSize: 14, weight: .regular)
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
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.7
        button.setTitle("Установить статус", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
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
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.isHidden = true
        button.alpha = 0
        button.addTarget(self, action: #selector(cancelAnimation), for: .touchUpInside)
        return button
    }()
   
    
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
        
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(27)
            make.leading.equalToSuperview().offset(152)
            make.trailing.equalToSuperview().offset(-10)
        }
       
        statusLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(enterStatus.snp.top).offset(-10)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        statusButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(166)
        }
        enterStatus.snp.makeConstraints{ make in
            make.bottom.equalTo(statusButton.snp.top).offset(-17)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        closePhotoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
      
    }
}

//MARK: - Extensions

extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            didTapSetButton()
        return true
    }
}


