//
//  Modifiers.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 14.12.2020.
//
import SwiftUI
import Foundation


struct DoubleShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0.0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0.0, y: 1)
    }
}

struct FontModifier: ViewModifier {
    var style: Font.TextStyle
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .default))
    }
}

struct CustomFontModifier: ViewModifier {
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom("WorkSans-Bold", size: size))
    }
}
