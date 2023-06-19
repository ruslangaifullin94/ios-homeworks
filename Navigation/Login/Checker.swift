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
    func check(_ login: String, _ pass: String) -> Result<Bool, CheckerError>
    func checkNew(_ login: String, _ pass: String) throws
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
    
    func check(_ login: String, _ pass: String) -> Result<Bool, CheckerError> {
       Checker.shared.check(login, pass)
    }
    
    func checkNew(_ login: String, _ pass: String) throws {
       try Checker.shared.checkNew(login, pass)
    }
   
}

final class Checker {
    
    static let shared = Checker()
    
    init() {}
    
    let login = "cat".hash
    
    let password = "catcat".hash
    
    func check(_ login: String, _ pass: String) -> Result<Bool, CheckerError> {
        
        
        guard login.hash == Checker.shared.login else {
            return .failure(.wrongLogin)
        }
        guard pass.hash == Checker.shared.password else {
            return .failure(.wrongPass)
        }
        return .success(true)
    }
    
    func checkNew(_ login: String, _ pass: String) throws  {
        if login.hash == Checker.shared.login && pass.hash == Checker.shared.password {
            return
        } else if login.hash != Checker.shared.login {
            throw CheckerError.wrongLogin
        } else if pass.hash != Checker.shared.password {
            throw CheckerError.wrongPass
        }
    }

}


