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
    static func getRequest(for configuration: AppConfiguration) {
        let url = URL(string: configuration.rawValue)!
        print(url)
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
            print(httpResponce.allHeaderFields)
            print(httpResponce.statusCode)
            
            
            guard let data else {
                return
            }

            do {
                if let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print(answer)
                } else {
                    print("error parsing")
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
