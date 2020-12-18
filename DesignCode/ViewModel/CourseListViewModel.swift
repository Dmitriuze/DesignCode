//
//  CourseListViewModel.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//
import SwiftUI
import Contentful
import Foundation

class CourseListViewModel: ObservableObject {
    
    @Published var courses: [Course] = []
    
    
    init() {
        CoutentfulApi().fetchData(id: "course") {data in
            data.forEach {item in
                self.courses.append(
                    Course(
                        title: item.fields["title"] as! String,
                        subtitle: item.fields["subtitle"] as! String,
                        image: #imageLiteral(resourceName: "Card6"),
                        logo: #imageLiteral(resourceName: "Logo1"),
                        color: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                        show: false
                    )
                )
            }
        }
    }
    
    

}
