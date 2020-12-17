//
//  CourseListViewModel.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//
import Contentful
import Foundation

class CourseListViewModel: ObservableObject {
    
    @Published var courses: [Course]
    
    let client = Contentful.Client(spaceId: "590jdx3i2vda", accessToken: "Pw1ecmmEuQRex33F7b2TK088_j7icfAbfK4tGKkWeNs")
    
    init() {
        self.courses = Course.getAll()
    }
    
    func fetchData() {
        let querry = Query.where(contentTypeId: "course")
        
        client.fetchArray(of: Entry.self, matching: querry) { result in
            print(result)
        }
    }

}
