//
//  PostListViewModel.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 17.12.2020.
//

import SwiftUI

class PostListViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    
    func fetchPosts() {
        PostsApi().getPosts { data in
            self.posts = data  
        }
    }
}
