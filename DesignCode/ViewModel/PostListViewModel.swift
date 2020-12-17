//
//  PostListViewModel.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 17.12.2020.
//

import SwiftUI

class PostListViewModel: ObservableObject {
    
    @Published var posts: [PostViewModel] = []
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        PostsApi().getPosts { data in
            self.posts = data  .map(PostViewModel.init)
        }
    }
}


struct PostViewModel: Identifiable {
    
    let post: Post
    
    var id: Int {
        self.post.id
    }
    
    var title: String {
        self.post.title.capitalized
    }
    
    var body: String {
        self.post.body
    }
}
