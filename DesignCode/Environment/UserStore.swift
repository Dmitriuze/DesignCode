//
//  UserStore.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 23.12.2020.
//

import Foundation


class UserStore: ObservableObject {
    
    @Published var isLogged = false
    @Published var showLogin = false
    
}
