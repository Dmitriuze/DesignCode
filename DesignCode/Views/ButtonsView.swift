//
//  ButtonsView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 20.12.2020.
//

import SwiftUI

struct ButtonsView: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9065141762, green: 0.9182558507, blue: 0.9820559452, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60, alignment: .center)
                .background(
                    ZStack {
                        Color(#colorLiteral(red: 0.7607843137, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(Color.white)
                            .blur(radius: 8)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9065141762, green: 0.9182558507, blue: 0.9820559452, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                        
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0.7607843137, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
