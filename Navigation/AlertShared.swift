//
//  AlertShared.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 02.07.2023.
//

import Foundation
import UIKit

final class AlertNotification {
    
    static let shared = AlertNotification()
    
    init () {}

    func presentAlert(_ viewController: UIViewController,_ error: String) {
        let optionMenu = UIAlertController(title: "Ошибка", message: "\(error)", preferredStyle: .alert)
        let optionAction = UIAlertAction(title: "Ok", style: .default)
        optionMenu.addAction(optionAction)
        viewController.present(optionMenu, animated: true)
    }
}
