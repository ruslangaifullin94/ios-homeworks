//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 08.03.2023.
//

import UIKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func saveToPoint(image: UIImageView) -> CGPoint
    func closePhoto(image: UIImageView, point: CGPoint)
}

final class ProfileHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    weak var delegate: ProfileViewControllerDelegate?
    private var statusText: String = ""
    var pointPhoto: CGPoint?
     private let setProfileAvatar: UIImageView = {
        let profileAvatar = UIImageView()
        profileAvatar.image = UIImage(named: "cat")
        profileAvatar.layer.borderWidth = 3
        profileAvatar.layer.cornerRadius = 60
        profileAvatar.clipsToBounds = true
        profileAvatar.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        profileAvatar.isUserInteractionEnabled = true
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
        label.text = "Нажми на меня для установки статуса"
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
    private lazy var statusButton: UIButton = {
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
        button.isHidden = true
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
    private lazy var backgroundPhoto: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    func animatePhoto(image: UIImageView) {
        let screen = UIScreen.main.bounds.width / image.bounds.width
        UIView.animateKeyframes(
            withDuration: 1.5,
            delay: 0.1,
            options: .calculationModeLinear,
            animations: {
//                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5)
//                    {
                        self.backgroundPhoto.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        image.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
                        image.transform = CGAffineTransform(scaleX: screen, y: screen)
                        image.layer.cornerRadius = 0.0
                        image.layer.borderWidth = 0
//                        self.backgroundPhotoView.alpha = 0.5

//                    }
            
            }
            )
    }
    
    @objc private func didTapPhotoAlert() {
        print("tap complete")
//        delegate?.openPhoto(image: setProfileAvatar)
        pointPhoto = delegate?.savePoint(image: setProfileAvatar)
//        delegate?.savePoint(image: setProfileAvatar)
        delegate?.presentAlert(image: setProfileAvatar)
        print(pointPhoto!)
        
        
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
       
        
        NSLayoutConstraint.activate([
            setProfileAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            setProfileAvatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            setProfileAvatar.widthAnchor.constraint(equalToConstant: 120),
            setProfileAvatar.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: setProfileAvatar.trailingAnchor, constant: 16),
            
            
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
            enterStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
           
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


