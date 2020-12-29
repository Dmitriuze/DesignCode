//
//  DesignCodeApp.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 13.12.2020.
//
import Firebase
import SwiftUI

@main
struct DesignCodeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
//            LoginView()
//            HomeScreenView()
//                .environmentObject(UserStore())
//            CourseListView()
        }
    }
}
