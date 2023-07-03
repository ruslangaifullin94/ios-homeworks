//
//  CheckerService.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 02.07.2023.
//

import Foundation

import FirebaseAuth


protocol CheckerServiceProtocol: AnyObject{
    func checkCredentials(_ email: String, _ password: String, completion: @escaping (User?, _ errorString: String?)->Void)
    func signUp(withEmail: String, withPass: String, completion: @escaping (Bool, _ errorString: String?)->Void)
}


final class CheckerService {
//    weak var delegate: CheckerServiceProtocol?
}


extension CheckerService: CheckerServiceProtocol {
    func checkCredentials(_ email: String, _ password: String, completion: @escaping (User?, _ errorString: String?)->Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil, error.localizedDescription)
                }
               
            }
            
            guard let user = authResult?.user else {
                DispatchQueue.main.async {
                    completion(nil, error?.localizedDescription)
                }
                return
            }
            let newUser = User(userLogin: user.email!, userName: user.email!, userStatus: "")
            completion(newUser, nil)
            
        }
    }
    
    func signUp(withEmail: String, withPass: String, completion: @escaping (Bool, _ errorString: String?)->Void){
        Auth.auth().createUser(withEmail: withEmail, password: withPass) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(false, "Такой email уже зарегистрирован")
                case AuthErrorCode.weakPassword.rawValue:
                    completion(false, "Необходимо ввести пароль длиннее")
                default:
                    completion(false, "Что-то пошло не так, попробуйте еще раз")
                }
            } else {
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            }
        }
    }
    
    
}
