//
//  CustomButton.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import UIKit

final class CustomButton: UIButton {
    
    
    private var buttonAction: () -> Void
    
    init(title: String, titleColor: UIColor, buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.alpha = 1
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
        self.buttonAction()
    }
}
