//
//  CoursesApi.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 17.12.2020.
//
import Contentful
import Foundation

class CoutentfulApi {
    
    let client = Contentful.Client(spaceId: "590jdx3i2vda", accessToken: "Pw1ecmmEuQRex33F7b2TK088_j7icfAbfK4tGKkWeNs")
    
    func fetchData(id: String, completion: @escaping (([Entry]) -> ())) {
        let querry = Query.where(contentTypeId: id)
        
        client.fetchArray(of: Entry.self, matching: querry) { result in
            switch result {
            case .success(let array):
                DispatchQueue.main.async {
                    completion(array.items)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
