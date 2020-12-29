//
//  CourseListViewModel.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//
import SDWebImage
import SwiftUI
import Contentful
import Foundation

class CourseListViewModel: ObservableObject {
    
    @Published var courses: [Course] = []
    
    
    init() {
        let colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)]
        var index = 0
        CoutentfulApi().fetchData(id: "course") {data in
            data.forEach {item in
                self.courses.append(
                    Course(
                        title: item.fields["title"] as! String,
                        subtitle: item.fields["subtitle"] as! String,
                        image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                        logo: #imageLiteral(resourceName: "Logo1"),
                        color: colors[index],
                        show: false
                    )
                )
                if index < colors.count {
                    index += 1
                } else {
                    index = 0
                }
            }
        }
    }
    
    

}
