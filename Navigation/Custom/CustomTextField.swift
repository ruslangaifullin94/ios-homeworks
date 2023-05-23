//
//  CustomTextField.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

final class CustomTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 0.5
        self.placeholder = placeholder
        self.textColor = .black
        self.font = .systemFont(ofSize: 16.0, weight: .regular)
        self.tintColor = UIColor(named: "MainColor")
        self.autocapitalizationType = .none
        self.backgroundColor = .systemGray6
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
