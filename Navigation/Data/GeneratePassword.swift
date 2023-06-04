//
//  GeneratePassword.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 04.06.2023.
//

import Foundation


final class GeneratePassword {
    
    static let shared = GeneratePassword()
    
    
    private let letters = ["a", "b", "c", "d", "e", "f", "g",
                           "h", "i", "j", "k", "l", "m", "n",
                           "o", "p", "q", "r", "s", "t", "u",
                           "v", "w", "x", "y", "z","A", "B",
                           "C", "D", "E", "F", "G", "H", "I",
                           "J", "K", "L", "M", "N", "O", "P",
                           "Q", "R", "S", "T", "U", "V", "W",
                           "X", "Y", "Z", "1", "2", "3", "4",
                           "5", "6", "7", "8", "9", "0"]
    
    func generatePassword(length: Int, completion: @escaping (String) -> Void) {
        
        DispatchQueue.global(qos: .background).async { [self] in
            
            var generatedPassword = ""
            for _ in 1...length  {
                generatedPassword.append(letters.randomElement()!)
            }
            print(generatedPassword)
            completion(generatedPassword)
            
        }
        
    }
    
}
