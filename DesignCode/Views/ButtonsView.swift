//
//  ButtonsView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 20.12.2020.
//

import SwiftUI

struct ButtonsView: View {
    
    @State private var tap = false
    @State private var press = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9065141762, green: 0.9182558507, blue: 0.9820559452, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60, alignment: .center)
                .background(
                    ZStack {
                        Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(Color(press ? #colorLiteral(red: 0.7607843137, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            .blur(radius: 8)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9065141762, green: 0.9182558507, blue: 0.9820559452, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(3)
                            .blur(radius: 3)
                        
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 24, weight: .light, design: .default))
                            .foregroundColor(Color.white.opacity(press ? 0 : 1))
                            .frame(width: press ? 34 : 54, height: press ? 4 : 50, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                            .offset(x: press ? 85 : -10, y: press ? 16 : 0)
                        Spacer()
                    }
                )
                .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7607843137, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                .shadow(color: Color(press ? #colorLiteral(red: 0.7607843137, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
                .scaleEffect(tap ? 1.2 : 1)
                .gesture(
                    LongPressGesture(minimumDuration: 0.5, maximumDistance: 10)
                        .onChanged { value in
                            self.tap = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.tap = false
                            }
                        }
                        .onEnded { value in
                            self.press.toggle()
                        }
                )
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
