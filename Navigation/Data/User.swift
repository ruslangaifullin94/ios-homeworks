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
    var password: String
//    init(userLogin: String, userAvatar: UIImage?, userName: String, userStatus: String) {
//        self.userLogin = userLogin
//        self.userAvatar = userAvatar
//        self.userName = userName
//        self.userStatus = userStatus
//    }
}

enum UserServiceError: Error {
    case wrongLogin
//    case wrongPassword
}
protocol UserService {
    func logInToUser(_ userLogin: String?) -> Result<User, UserServiceError>
}

internal var userData: [User] = [
    User(userLogin: "ruslan", userAvatar: UIImage(named: "rus"), userName: "Ruslan G", userStatus: "I love iOS", password: "rusrus"),
    User(userLogin: "kate", userAvatar: UIImage(named: "heart"), userName: "Kate G", userStatus: "I love Ruslan", password: "katekate"),
    User(userLogin: "cat", userAvatar: UIImage(named: "cat"), userName: "Cat Lucy", userStatus: "I love sleep", password: "catcat")
]

class CurrentUserService: UserService {
 
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

class TestUserService: UserService {
    
    let userCat = User(
        userLogin: "cat",
        userAvatar: UIImage(named: "cat"),
        userName: "CAt Lucy",
        userStatus: "I love Sleep",
        password: "testcat"
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
