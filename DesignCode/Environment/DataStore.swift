//
//  DataStore.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 17.12.2020.
//

import Foundation

class DataStore: ObservableObject {
    
    @Published var posts: [Post] = []
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        PostsApi().getPosts { data in
            self.posts = data
        }
    }
}
