//
//  CourseListView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//

import SwiftUI

struct CourseListView: View {
    
    var body: some View {
        
        VStack {
            CourseView()
        }
    }
}


struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}

struct CourseView: View {
    
    @State private var show = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading,  spacing: 30) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                
                Text("About this course").font(.title).bold()
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
            }.padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? screen.height / 2 + 10 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0.0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 20){
                        Text("SwiftUI Advanced")
                            .font(.system(size: 24, weight: .bold))
                        Text("20 sections")
                            .opacity(0.7)
                    }
                    Spacer()
                    ZStack {
                        Image("Logo1").opacity(show ? 0 : 1)
                        
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white).frame(width: 40, height: 40, alignment: .center)
                            .background(Color.black)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 10)
                            .opacity(show ? 1 : 0)
                    }
                }.foregroundColor(Color.white)
                Spacer()
                
                Image(uiImage: #imageLiteral(resourceName: "Card2"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                
            }
            .padding(show ? 40 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? screen.height / 2 : 280)
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 20, x: 0.0, y: 20)
            .onTapGesture {
                self.show.toggle()
            }
            
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}
