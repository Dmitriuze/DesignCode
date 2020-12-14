//
//  HomeViewModel.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 14.12.2020.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var sections: [Section]
    
    init() {
        self.sections = Section.getAll()
    }
}
