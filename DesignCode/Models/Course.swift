//
//  Course.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//
import SwiftUI
import Foundation

struct Course: Identifiable {
    
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

extension Course {
    static func getAll() -> [Course] {
        return [
            Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: URL(string: "")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
            Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: URL(string: "")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
            Course(title: "UI Design for Developers", subtitle: "20 Sections", image: URL(string: "")!, logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
         ]
    }
}
