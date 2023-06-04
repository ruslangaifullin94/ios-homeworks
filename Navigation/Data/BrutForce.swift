//
//  BrutForce.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 04.06.2023.
//

import Foundation

final class BruteForce {
    static let shared = BruteForce()

//#if DEBUG
//private let userPswrd = ""
//#else
//    private let userPswrd = GeneratePassword.shared.generatedPassword
//#endif

    private init() {}

    func bruteForcePublic(passwordToUnlock: String, completion: @escaping (String) -> Void) {
            completion(self.bruteForce(passwordToUnlock: passwordToUnlock))
    }


    private func bruteForce(passwordToUnlock: String) -> String {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = generateBruteForce(string: password, fromArray: ALLOWED_CHARACTERS)
            // Your stuff here
        }

        return password
    }
func indexOf(character: Character,  array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int,  array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }

    func generateBruteForce( string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array: array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array: array) + 1) % array.count, array: array))

            if indexOf(character: str.last!, array: array) == 0 {
                str = String(generateBruteForce(string: String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }

}


extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[]^`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }


    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
