//
//  Api.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 17.12.2020.
//

import Foundation


class PostsApi {
    
    func getPosts(completion: @escaping ([Post]) -> ())  {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { fatalError("Invalid URL") }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data, error == nil else { fatalError("Data is nil") }
            if let decodedData = try? JSONDecoder().decode([Post].self, from: data) {
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            }
        }.resume()
    }
}
