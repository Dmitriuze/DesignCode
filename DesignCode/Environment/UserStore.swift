//
//  UserStore.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 23.12.2020.
//

import Foundation


class UserStore: ObservableObject {
    
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.setValue(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
    
    
    
}
