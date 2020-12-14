//
//  Section.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 14.12.2020.
//
import SwiftUI
import Foundation


struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

extension Section {
    static func getAll() -> [Section] {
        return [
            Section(title: "Prototypes designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image("Card1"), color: .card1),
            Section(title: "Build a SwiftUI App", text: "20 Sections", logo: "Logo1", image: Image("Card2"), color: .card2),
            Section(title: "SwiftUI Advanced", text: "20 Sections", logo: "Logo1", image: Image("Card3"), color: .card3)
        ]
    }
}
