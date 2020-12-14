//
//  SwiftUIView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 14.12.2020.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text("Hello, World!")
            .modifier(CustomFontModifier())
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
