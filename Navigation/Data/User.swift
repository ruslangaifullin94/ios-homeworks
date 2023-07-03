//
//  User.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 12.05.2023.
//

import UIKit

struct User {
    var userLogin: String
    var userAvatar: UIImage?
    var userName: String
    var userStatus: String
}

enum UserServiceError: Error {
    case wrongLogin
    
    var errorDescription: String {
        switch self {
        case .wrongLogin:
            return "Неправильный логин"
        }
    }
}
protocol UserService {
    func logInToUser(_ userLogin: String?) -> Result<User, UserServiceError>
}

internal var userData: [User] = [
    User(userLogin: "ruslan", userAvatar: UIImage(named: "rus"), userName: "Ruslan G", userStatus: "I love iOS"),
    User(userLogin: "kate", userAvatar: UIImage(named: "heart"), userName: "Kate G", userStatus: "I love Ruslan"),
    User(userLogin: "cat", userAvatar: UIImage(named: "cat"), userName: "Cat Lucy", userStatus: "I love sleep")
]

final class CurrentUserService: UserService {
 
    func logInToUser(_ userLogin: String?) -> Result<User, UserServiceError> {
        if let index = userData.firstIndex(where: {$0.userLogin == userLogin}) {
            if userLogin == userData[index].userLogin {
                return .success(userData[index])
            } else {
                return .failure(.wrongLogin)
            }
        } else {
            return .failure(.wrongLogin)
        }
    }
    
}

final class TestUserService: UserService {
    
    let userCat = User(
        userLogin: "cat",
        userAvatar: UIImage(named: "cat"),
        userName: "CAt Lucy",
        userStatus: "I love Sleep"
    )
    
    func logInToUser(_ userLogin: String?) -> Result<User, UserServiceError> {
        guard let userLogin = userLogin else {
            return .failure(.wrongLogin)
        }
        guard userLogin == userCat.userLogin else {
            return .failure(.wrongLogin)
        }
        return .success(userCat)
    }
    
    
    
}
