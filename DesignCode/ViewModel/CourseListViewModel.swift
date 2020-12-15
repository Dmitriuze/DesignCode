//
//  CourseListViewModel.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//

import Foundation

class CourseListViewModel: ObservableObject {
    
    @Published var courses: [Course]
    
    init() {
        self.courses = Course.getAll()
    }
}
