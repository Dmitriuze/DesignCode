//
//  PostListView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 17.12.2020.
//

import SwiftUI

struct PostListView: View {
    
    @ObservedObject var postListVM = PostListViewModel()
    
    var body: some View {
        List {
            ForEach(postListVM.posts, id: \.id) {post in
                VStack(alignment: .leading) {
                    Text(post.title.capitalized)
                        .font(.title).bold()
                }
            }
        }
        .onAppear {
            postListVM.fetchPosts()
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
