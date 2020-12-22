//
//  LoadingView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 22.12.2020.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(fileName: "loading")
                .frame(width: 200, height: 200)
            LottieView(fileName: "success")
                .frame(width: 200, height: 200)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
