//
//  CourseDetailView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 17.12.2020.
//

import SwiftUI

struct CourseDetailView: View {
    
    @Binding var course: Course
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    var body: some View {
        
        VStack {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 20){
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                        Text(course.subtitle)
                            .opacity(0.7)
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo).opacity(course.show ? 0 : 1)
                        
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white).frame(width: 40, height: 40, alignment: .center)
                            .background(Color.black)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 10)
                            .opacity(course.show ? 1 : 0)
                            .onTapGesture {
                                self.course.show = false
                                self.active = false
                                self.activeIndex = -1
                            }
                    }
                }.foregroundColor(Color.white)
                
                Spacer()
                
                Image(uiImage: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                
            }
            .padding(course.show ? 40 : 20)
            .padding(.top, course.show ? 30 : 0)
            .frame(maxWidth: course.show ? .infinity : screen.width - 60)
            .frame(height: course.show ? screen.height / 2 : 280)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0.0, y: 20)
            ScrollView {
                VStack(alignment: .leading,  spacing: 30) {
                    Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                    
                    Text("About this course").font(.title).bold()
                    
                    Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                }.padding(30)
            }
        }
        .gesture(
            course.show ?
                DragGesture()
                .onChanged {value in
                    guard value.translation.width < 300 && value.translation.width > -300 else { return }
                    
                    self.activeView = value.translation
                    
                }
                .onEnded {value in
                    if self.activeView.width > 50 || self.activeView.width < -50{
                        self.course.show = false
                        self.active = false
                        self.activeIndex = -1
                    }
                    self.activeView = .zero
                }
                : nil
        )
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    @State static var course = Course.getAll()[0]
    static var previews: some View {
        CourseDetailView(course: $course, active: .constant(true), activeIndex: .constant(-1), activeView: .constant(.zero))
    }
}
