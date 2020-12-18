//
//  MenuView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 13.12.2020.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 20) {
                
                Text("Meng - 28% complete")
                    .font(.caption)
                Color.white
                    .frame(width: 38, height: 6)
                    .cornerRadius(6)
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0.0, y: 5)
                    .frame(width: 130, height: 6, alignment: .leading)
                    .background(Color.black.opacity(0.08).cornerRadius(6))
                    .frame(width: 150, height: 24, alignment: .center)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8029412627, green: 0.8307031989, blue: 0.8764169812, alpha: 1)), Color(#colorLiteral(red: 0.8619921803, green: 0.8817352057, blue: 0.9232407212, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing).cornerRadius(12))
                    .overlay(Capsule().strokeBorder(Color.white, lineWidth: 1))
                
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign Out", icon: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(BlurView(style: .systemMaterial)
            )
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0.0, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .offset(y: -150)
            )
        }.padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light, design: .default))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
