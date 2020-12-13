//
//  HomeView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 13.12.2020.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                AvatarView(showProfile: self.$showProfile)
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(0..<3) { item in
                        SectionView()
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }
            
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(true))
    }
}

struct SectionView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Prototypes designs in SwiftUI")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image("Logo1")
            }
            Text("18 sections".uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
        .frame(width: 275, height: 275, alignment: .center)
        .background(Color.card1)
        .cornerRadius(30)
        .shadow(color: Color.card1.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}
