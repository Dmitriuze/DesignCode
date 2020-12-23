//
//  HomeView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 13.12.2020.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var showProfile = false
    @State private var viewState = CGSize.zero
    @State private var showContent = false
    @EnvironmentObject var user: UserStore
    
    var body: some View {
        ZStack {
            
            Color.background2
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: self.$showProfile, showContent: self.$showContent)
                .padding(.top, 44)
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color.background2, Color.background1]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    .background(Color.background1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: self.showProfile ? self.viewState.height - 450 : 0)
                .rotation3DEffect(.degrees(self.showProfile ? Double(self.viewState.height / 10) - 10 : 0),
                                  axis: (x: 10.0, y: 0.0, z: 0.0))
                .scaleEffect(self.showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            MenuView(showProfile: $showProfile)
                .background(Color.black.opacity(0.001))
                .offset(y: self.showProfile ? 0 : screen.height)
                .offset(y: self.viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged {value in
                            self.viewState = value.translation
                        }
                        .onEnded {value in
                            if self.viewState.height > 50 {
                                self.showProfile = false
                            }
                            self.viewState = .zero
                        }
                )
            
            if user.showLogin {
                ZStack {
                    
                    LoginView()
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                                .onTapGesture {
                                    self.user.showLogin = false
                                }
                        }
                        Spacer()
                    }.padding()
                    
                }
                .animation(.linear)
            }
            
            if self.showContent {
                BlurView(style: .systemMaterial)
                    .edgesIgnoringSafeArea(.all)
                
                CertificateView()
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.showContent = false
                            }
                    }
                    Spacer()
                }
                .transition(.move(edge: .bottom))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .padding(.horizontal)
                
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environment(\.colorScheme, .dark)
            .environment(\.sizeCategory, .extraExtraLarge)
            .environmentObject(UserStore())
    }
}

struct AvatarView: View {
    
    @Binding var showProfile: Bool
    @EnvironmentObject var user: UserStore
    
    var body: some View {
        VStack {
            if user.isLogged {
                Button(action: {
                    self.showProfile.toggle()
                }, label: {
                    Image("Avatar")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                })
            } else {
                Button(action: {
                    self.user.showLogin.toggle()
                }, label: {
                    Image(systemName: "person")
                        .foregroundColor(.primary)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.background3)
                        .clipShape(Circle())
                        .modifier(DoubleShadowModifier())
                    
                })
            }
        }
    }
}

let screen = UIScreen.main.bounds
