//
//  Checker.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 18.05.2023.
//

import UIKit

enum CheckerError: Error {
    case wrongLogin
    case wrongPass
    
    var errorDescription: String {
        switch self {
        case .wrongLogin:
            return "Неверный логин"
        case .wrongPass:
            return "Неправильный пароль"
        }
    }
}

protocol LoginViewControllerDelegate {
    func check(_ login: String?, _ pass: String?) -> Result<Bool, CheckerError>
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        let inspector = LoginInspector()
        
        return inspector
    }
    
    
}
struct LoginInspector: LoginViewControllerDelegate {
    
    func check(_ login: String?, _ pass: String?) -> Result<Bool, CheckerError> {
        
        guard login == Checker.shared.login else {
            return .failure(.wrongLogin)
        }
        guard pass == Checker.shared.password else {
            return .failure(.wrongPass)
        }
        return .success(true)
    }
}

class Checker {
    
    static let shared = Checker()
    
    init() {}
    
    let login = "cat"
    
    let password = "catcat"
    

}


