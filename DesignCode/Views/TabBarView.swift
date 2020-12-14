//
//  TabBarView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 14.12.2020.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeScreenView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            CertificateView()
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Certificate")
                }
            
        }.edgesIgnoringSafeArea(.top)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
