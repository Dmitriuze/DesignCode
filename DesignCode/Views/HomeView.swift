//
//  HomeView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 13.12.2020.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var homeVM = HomeViewModel()
    
    @Binding var showProfile: Bool
    @State var showUpdate: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .modifier(CustomFontModifier(size: 28))
//                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                AvatarView(showProfile: self.$showProfile)
                
                Button(action: { self.showUpdate.toggle() }, label: {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                        .modifier(DoubleShadowModifier())
                })
                .sheet(isPresented: $showUpdate, content: {
                    UpdateListView()
                })
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                WatchRingsView()
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(self.homeVM.sections, id: \.id) { section in
                        GeometryReader { geometry in
                            SectionView(section: section)
                                .rotation3DEffect(
                                    .degrees((Double(geometry.frame(in: .global).minX - 30) / -20)),
                                    axis: (x: 0, y: 1, z: 0))
                        }
                        .frame(width: 275, height: 275)
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
    var section: Section
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
        .frame(width: 275, height: 275, alignment: .center)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}






struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            
            HStack {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 68)
                VStack(alignment: .leading, spacing: 4){
                    Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
                    
                    Text("Watched 10 minutes today").modifier(FontModifier(style: .caption))
                }
                
            }.padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(DoubleShadowModifier())
            
            HStack {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), width: 32, height: 32, percent: 54)
                
            }.padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(DoubleShadowModifier())
            
            HStack {
                RingView(color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), width: 32, height: 32, percent: 32)
                
            }.padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(DoubleShadowModifier())
        }
    }
}
