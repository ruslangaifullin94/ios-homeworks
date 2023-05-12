//
//  User.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 12.05.2023.
//

import Foundation
import UIKit

class User {
    var userLogin: String
    var userAvatar: UIImage?
    var userName: String
    var userStatus: String
    
    init(userLogin: String, userAvatar: UIImage?, userName: String, userStatus: String) {
        self.userLogin = userLogin
        self.userAvatar = userAvatar
        self.userName = userName
        self.userStatus = userStatus
    }
}
enum UserServiceError: Error {
    case wrongLogin
//    case wrongPassword
    case uncorrectLogin
}
protocol UserService {
    func logInToUser(_ userLogin: String?) -> Result<User, UserServiceError>
}

class CurrentUserService: UserService {
    
    let userRuslan = User(
        userLogin: "ruslan",
        userAvatar: UIImage(named: "rus"),
        userName: "Ruslan G",
        userStatus: "I love iOS"
    )
    
//    private var user: User
//
//    init(user:User) {
//        self.user = user
//    }
    
    func logInToUser(_ userLogin: String?) -> Result<User, UserServiceError> {
        guard let userLogin = userLogin else {
            return .failure(.uncorrectLogin)
        }
        guard userLogin == userRuslan.userLogin else {
            return .failure(.wrongLogin)
        }
        return .success(userRuslan)
    }
    
}

class TestUserService: UserService {
    
    let userCat = User(
        userLogin: "cat",
        userAvatar: UIImage(named: "cat"),
        userName: "CAt Lucy",
        userStatus: "I love Sleep"
    )
    
    func logInToUser(_ userLogin: String?) -> Result<User, UserServiceError> {
        guard let userLogin = userLogin else {
            return .failure(.uncorrectLogin)
        }
        guard userLogin == userCat.userLogin else {
            return .failure(.wrongLogin)
        }
        return .success(userCat)
    }
    
    
    
}
