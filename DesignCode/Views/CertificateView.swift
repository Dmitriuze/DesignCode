//
//  ContentView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 13.12.2020.
//

import SwiftUI

struct CertificateView: View {
    
    @State private var mainCardIsDraggin = false
    @State private var mainCardPosition = CGSize.zero
    @State private var bottomCardIsShown = false
    @State private var bottomCardPosition = CGSize.zero
    @State private var bottomCardIsFull = false
    
    var body: some View {
        ZStack {
            TitleView()
                .opacity(self.bottomCardIsShown ? 0.6 : 1)
                .offset(y: self.bottomCardIsShown ? -200 : 0)
                .blur(radius: self.mainCardIsDraggin ? 20 : 0)
                .animation(Animation.default.delay(0.1))
            
            BackCardView()
                .background(self.mainCardIsDraggin ? Color.card3 : Color.card4)
                .clipShape(RoundedRectangle(cornerRadius: self.bottomCardIsShown ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: 0, y: self.mainCardIsDraggin ? -400 : -40)
                .offset(x: self.mainCardPosition.width, y: self.mainCardPosition.height)
                .offset(y: self.bottomCardIsShown ? -165 : 0)
                .scaleEffect(self.bottomCardIsShown ? 1 : 0.9)
                .rotationEffect(.degrees(self.mainCardIsDraggin ? 0 : 10))
                .rotationEffect(.degrees(self.bottomCardIsShown ? -10 : 0))
                .rotation3DEffect(
                    .degrees(self.bottomCardIsShown ? 0 : 10),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            BackCardView()
                .background(self.mainCardIsDraggin ? Color.card4 : Color.card3)
                .clipShape(RoundedRectangle(cornerRadius: self.bottomCardIsShown ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: 0, y: self.mainCardIsDraggin ? -200 : -20)
                .offset(x: self.mainCardPosition.width, y: self.mainCardPosition.height)
                .offset(y: self.bottomCardIsShown ? -120 : 0)
                .scaleEffect(self.bottomCardIsShown ? 1.1 : 0.95)
                .rotationEffect(.degrees(self.mainCardIsDraggin ? 0 : 5))
                .rotationEffect(.degrees(self.bottomCardIsShown ? -5 : 0))
                .rotation3DEffect(
                    .degrees(self.bottomCardIsShown ? 0 : 5),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            CardView()
                .clipShape(RoundedRectangle(cornerRadius: self.bottomCardIsShown ? 30 : 20, style: .continuous))
                .scaleEffect(self.bottomCardIsShown ? 1.2 : 1)
                .shadow(radius: 20)
                .offset(x: self.mainCardPosition.width, y: self.mainCardPosition.height)
                .offset(y: self.bottomCardIsShown ? -100 : 0)
                .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
                .blendMode(.hardLight)
                .onTapGesture {
                    self.bottomCardIsShown.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged {value in
                            self.mainCardPosition = value.translation
                            self.mainCardIsDraggin = true
                        }
                        .onEnded {_ in
                            self.mainCardPosition = CGSize.zero
                            self.mainCardIsDraggin = false
                        }
                )
            
            BottomCardView()
                .offset(y: self.bottomCardIsShown ? 160 : 1000)
                .offset(y: self.bottomCardPosition.height)
                .blur(radius: self.mainCardIsDraggin ? 30 : 0)
                .animation(.timingCurve(1,0.11,0.41,1.06, duration: 0.3))
                .gesture(
                    DragGesture()
                        .onChanged {value in
                            self.bottomCardPosition = value.translation
                            
                            if self.bottomCardIsFull {
                                self.bottomCardPosition.height += -300
                            }
                            
                            if self.bottomCardPosition.height < -300 {
                                self.bottomCardPosition.height = -300
                            }
                        }
                        .onEnded {_ in
                            if self.bottomCardPosition.height > 50 {
                                self.bottomCardIsShown = false
                                self.bottomCardIsFull = false
                            } else if (self.bottomCardPosition.height < -100 && !self.bottomCardIsFull) || (self.bottomCardPosition.height < -250 && self.bottomCardIsFull) {
                                self.bottomCardIsFull = true
                                self.bottomCardPosition.height = -300
                            } else {
                                self.bottomCardIsFull = false
                                self.bottomCardPosition.height = .zero
                            }
                        }
                )
        }
    }
}

struct CertificateView_Previews: PreviewProvider {
    static var previews: some View {
        CertificateView()
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

struct BottomCardView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 40, height: 5, alignment: .center)
                .opacity(0.1)
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 78, withAnimation: false)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUI").fontWeight(.bold)
                    Text("12 of 12 sections completed\n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(BlurView(style: .systemThickMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
