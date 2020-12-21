//
//  LoginView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 21.12.2020.
//

import SwiftUI

struct LoginView: View {
    @State private var show = false
    @State private var viewState = CGSize.zero
    @State private var isDragging = false
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .ignoresSafeArea()
            Color.background2
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .edgesIgnoringSafeArea(.bottom)
            VStack(alignment: .center) {
                GeometryReader { geometry in
                    Text("Learn design & code. \nFrom scratch.")
                        .font(.system(size: geometry.size.width / 10, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 375, maxHeight: 100)
                .padding(.horizontal, 16)
                
                Text("80 hours of courses for SwiftUI, React and design tools.")
                    .font(.subheadline)
                    .frame(width: 250)
                
                Spacer()
            }
            .offset(x: viewState.height / -20, y: viewState.width / -20)
            .multilineTextAlignment(.center)
            .padding(.top, 100)
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -150, y: -200)
                        .rotationEffect(.degrees(show ? 360 : 90))
                        .blendMode(.plusDarker)
                        .animation(Animation.linear(duration: 120).repeatForever())
                        .onAppear{self.show = true}
                        .scaleEffect(show ? 1.4 : 1)
                        .animation(Animation.linear(duration: 10).repeatForever(autoreverses: true))
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -200, y: -250)
                        .rotationEffect(.degrees(show ? 360 : 0), anchor: .leading)
                        .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                        .blendMode(.colorDodge)
                        .scaleEffect(show ? 0.7 : 1.1)
                        .animation(Animation.linear(duration: 10).repeatForever(autoreverses: true))
                }
            )
            .background(Image(uiImage: #imageLiteral(resourceName: "Card3"))
                            .clipShape(RoundedRectangle(cornerRadius: isDragging ? 30.0 : 0, style: .continuous)).offset(x: viewState.height / -20, y: viewState.width / -20)
                        , alignment: .bottom)
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(
                .degrees(5),
                axis: (x: viewState.width , y: viewState.height, z: 0.0))
            .scaleEffect(isDragging ? 0.9 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(isDragging ? 0.4 : 0), radius: 20, x: self.viewState.height / -10, y: self.viewState.width / -10)
            .gesture(
                DragGesture().onChanged {value in
                    self.viewState = value.translation
                    self.isDragging = true
                }
                .onEnded {value in
                    self.viewState = .zero
                    self.isDragging = false
                }
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
