//
//  RingView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 14.12.2020.
//

import SwiftUI

struct RingView: View {
    
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var width: CGFloat = 88
    var height: CGFloat = 88
    var percent: CGFloat = 88
    
    var body: some View {
        let multiplier = width / 44
        let progress = 1 - percent / 100
        
        ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: multiplier * 5))
                .frame(width: width, height: height)
            Circle()
                .trim(from: progress, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .bevel, miterLimit: .infinity, dash: [20,0], dashPhase: 0))
                .rotationEffect(.degrees(90))
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.2), radius: 3 * multiplier, x: 0.0, y: 3 * multiplier)
            Text("\(percent, specifier: "%.0f")%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
        }
        
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
