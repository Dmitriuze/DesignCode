//
//  ContentView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 13.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var mainCardIsShown = false
    @State private var mainCardPosition = CGSize.zero
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: self.mainCardIsShown ? 20 : 0)
                .animation(.default)
            
            BackCardView()
                .background(self.mainCardIsShown ? Color.card3 : Color.card4)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: self.mainCardIsShown ? -400 : -40)
                .offset(x: self.mainCardPosition.width, y: self.mainCardPosition.height)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(self.mainCardIsShown ? 0 : 10))
                .rotation3DEffect(
                    .degrees(10),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.4))
            
            BackCardView()
                .background(self.mainCardIsShown ? Color.card4 : Color.card3)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: self.mainCardIsShown ? -200 : -20)
                .offset(x: self.mainCardPosition.width, y: self.mainCardPosition.height)
                .scaleEffect(0.95)
                .rotationEffect(.degrees(self.mainCardIsShown ? 0 : 5))
                .rotation3DEffect(
                    .degrees(5),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            CardView()
                .offset(x: self.mainCardPosition.width, y: self.mainCardPosition.height)
                .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
                .blendMode(.hardLight)
                .onTapGesture {
                    self.mainCardIsShown.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged {value in
                            self.mainCardPosition = value.translation
                            self.mainCardIsShown = true
                        }
                        .onEnded {_ in
                            self.mainCardPosition = CGSize.zero
                            self.mainCardIsShown = false
                        }
                )
            
            ButtonCardView()
                .blur(radius: self.mainCardIsShown ? 30 : 0)
                .animation(.default)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(.accent)
                }
                Spacer()
                Image("Logo1")
                
            }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
            
        }
        .frame(width: 340, height: 220)
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
            
        }
        .frame(width: 340, height: 220, alignment: .center)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }.padding()
            
            Image("Background1")
            Spacer()
        }
    }
}

struct ButtonCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 40, height: 5, alignment: .center)
                .opacity(0.1)
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        .offset(x: 0, y: 650)
    }
}
