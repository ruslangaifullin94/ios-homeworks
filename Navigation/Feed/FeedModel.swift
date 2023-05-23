//
//  FeedModel.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 23.05.2023.
//

import Foundation

protocol FeedModelProtocol {
    func check(_ pass: String?, completion: @escaping (Result<Bool, SecretError>) -> Void)
}

enum SecretError: Error {
    case noWord
    case uncorrectWord
}

final class FeedModel {
        
    private var secretWord = "pass"
    
}

extension FeedModel: FeedModelProtocol {
    
    func check(_ pass: String?, completion: @escaping (Result<Bool, SecretError>) -> Void) {
        guard pass == "" else {
            guard pass == secretWord else {
                return completion(.failure(.uncorrectWord))
            }
            return completion(.success(true))
        }
        return completion(.failure(.noWord))
    }
}
