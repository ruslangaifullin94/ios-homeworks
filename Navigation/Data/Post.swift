//
//  Post.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 07.03.2023.
//
import UIKit
import Foundation
struct Post {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}
extension Post {
    static func make() -> [Post] {
        [
            Post(
                 author: "vedmak.official",
                 description: "Новые кадры со съемок второго сезона легенадраного нашумевшего сериала Ведьмак",
                 image: "vedmak",
                 likes: 213,
                 views: 1280
            ),
            Post(
                author: "dzen",
                description: "попробуй новую площадку для твоих статей и публикаций. Легкие настройки монетизации",
                image: "dzen",
                likes: 1348,
                views: 6890
            ),
            Post(
                author: "Apple",
                description: "Презентация нового Iphone 14 Pro",
                image: "apple",
                likes: 378,
                views: 789
            ),
            Post(
                author: "Valve",
                description:
"""
Студия Valve показала в своем YouTube-канале несколько видеороликов, посвященных игре Counter-Strike 2, которая выйдет летом 2023 года.
По словам разработчиков, геймплей станет динамичнее за счет графических улучшений, реализованных на движке Source 2. Отмечается, что теперь дым в игре выглядит реалистичнее, реагирует на выстрелы и взрывы.
В компании также уточнили, что Source 2 позволил повысить качество освещения и сделать правдоподобную систему рендеринга, создающую реалистичные текстуры.
""",
                image: "counter-strike",
                likes: 3897,
                views: 48901
            )
        ]
    }
}
