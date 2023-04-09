//
//  Photos.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 03.04.2023.
//

import Foundation
import UIKit
struct Photo {
    let imageTitle: String
}
extension Photo {
    static func make() -> [Photo] {
        [
            Photo(imageTitle: "photo1"),
            Photo(imageTitle: "photo2"),
            Photo(imageTitle: "photo3"),
            Photo(imageTitle: "photo4"),
            Photo(imageTitle: "photo5"),
            Photo(imageTitle: "photo6"),
            Photo(imageTitle: "photo7"),
            Photo(imageTitle: "photo8"),
            Photo(imageTitle: "photo9"),
            Photo(imageTitle: "photo10"),
            Photo(imageTitle: "photo11"),
            Photo(imageTitle: "photo12"),
            Photo(imageTitle: "photo13"),
            Photo(imageTitle: "photo14"),
            Photo(imageTitle: "photo15"),
            Photo(imageTitle: "photo16"),
            Photo(imageTitle: "photo17"),
            Photo(imageTitle: "photo18"),
            Photo(imageTitle: "photo19"),
            Photo(imageTitle: "photo20")
        ]
    }
}
