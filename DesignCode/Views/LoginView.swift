//
//  LoginView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 21.12.2020.
//
import Firebase
import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isFocused = false
    @State private var showAlert = false
    @State private var alertMessage = "Something went wrong"
    @State private var isLoading = false
    @State private var isSuccess = false
    @EnvironmentObject var user: UserStore
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func login() {
        self.hideKeyboard()
        self.isFocused = false
        self.isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { (relust, error) in
            
            self.isLoading = false
            
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? ""
                self.isLoading = false
                self.showAlert = true
            } else {
                self.isSuccess = true
                self.user.isLogged = true
                UserDefaults.standard.setValue(true, forKey: "isLogged")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.email = ""
                    self.password = ""
                    self.isSuccess = false
                    self.user.showLogin = false
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ZStack(alignment: .top) {
                Color.background2
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                CoverView()
                    .offset(y: isFocused ? -300 : 0)
                VStack {
                    
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        TextField("Email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                    
                    Divider().padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        SecureField("Password".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                            }
                    }
                    
                }
                .frame(height: 136)
                .frame(maxWidth: 712)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y: 460)
                .offset(y: isFocused ? -300 : 0)
                HStack {
                    
                    Text("Forgot password?")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Button(action: {
                        self.login()
                    }, label: {
                        Text("Log in").foregroundColor(.black)
                            .padding(12)
                            .padding(.horizontal, 30)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.5241669825, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    })
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.15), radius: 20, x: 0, y: 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
            }
            .animation(.easeInOut)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
            .blur(radius: isLoading ? 1 : 0)
            
            if isLoading {
                LottieView(fileName: "loading")
                    .frame(width: 250, height: 250)
            }
            
            if isSuccess {
                SuccessView()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CoverView: View {
    
    @State private var show = false
    @State private var viewState = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
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
                    .rotationEffect(.degrees(show ? -180 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 120).repeatForever())
                    .onAppear{self.show = true}
                    .scaleEffect(show ? 1.4 : 1)
                    .animation(Animation.linear(duration: 10).repeatForever(autoreverses: true))
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250)
                    .rotationEffect(.degrees(show ? 180 : 0), anchor: .leading)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                    .blendMode(.colorDodge)
                    .scaleEffect(show ? 0.7 : 1.1)
                    .animation(Animation.linear(duration: 10).repeatForever(autoreverses: true))
            }
        )
        .background(
            Image(uiImage: #imageLiteral(resourceName: "Card3"))
                .clipShape(RoundedRectangle(cornerRadius: isDragging ? 30.0 : 0, style: .continuous))
                .offset(x: viewState.height / -20, y: viewState.width / -20)
            , alignment: .bottom
        )
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
