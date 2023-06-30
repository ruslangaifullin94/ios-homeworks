//
//  NetworkService.swift
//  Navigation
//
//  Created by Руслан Гайфуллин on 28.06.2023.
//

import Foundation

enum AppConfiguration: String {
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"
}

struct NetworkService {
    static func getRequest(id: Int = (1...200).randomElement()!, completion: @escaping (_ titleText: String) -> Void ) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/\(id)")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, responce, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let httpResponce = responce as? HTTPURLResponse else {
                print("error responce")
                return
            }
            guard let data else {
                return
            }

            do {
                if let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    completion(answer["title"] as! String)
                } else {
                    print("error parsing")
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    static func getOrbitalPeriod(completion: @escaping (_ orbitalPeriod: String) -> Void) {
        let url = URL(string: "https://swapi.dev/api/planets/1")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, responce, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let data else {
                print("error decoding")
                return
            }
            do {
                let answer = try JSONDecoder().decode(Planet.self, from: data)
                completion(answer.orbitalPeriod)
            } catch {
                print("error parsing")
            }
        }
        task.resume()
    }
}
