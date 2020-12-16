//
//  CourseListView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//

import SwiftUI

struct CourseListView: View {
    
    @ObservedObject private var courseListVM = CourseListViewModel()
    @State private var active = false
    @State private var activeIndex: Int = -1
    @State private var activeView = CGSize.zero
    
    var body: some View {
        
        ZStack {
            Color.black.opacity(Double(activeView.width / 500))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 30) {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                    ForEach(courseListVM.courses.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            
                            CourseView(
                                course: $courseListVM.courses[index],
                                active: $active,
                                index: index,
                                activeIndex: $activeIndex,
                                activeView: $activeView
                            )
                            .offset(y: courseListVM.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                            .opacity(self.activeIndex != index && self.active ? 0 : 1)
                            .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                            .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                            
                        }
                        .frame(height: 280)
                        .frame(maxWidth: courseListVM.courses[index].show ? .infinity : screen.width - 60, maxHeight: .infinity)
                        .zIndex(courseListVM.courses[index].show ? 1 : 0)
                    }
                }.frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
        }
    }
}


struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
        
        
    }
}

struct CourseView: View {
    
    @Binding var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading,  spacing: 30) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                
                Text("About this course").font(.title).bold()
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
            }.padding(30)
            .frame(maxWidth: course.show ? .infinity : screen.width - 60, maxHeight: course.show ? .infinity : 280, alignment: .top)
            .offset(y: course.show ? screen.height / 2 + 10 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0.0, y: 20)
            .opacity(course.show ? 1 : 0)
            
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
            .frame(maxWidth: course.show ? .infinity : screen.width - 60, maxHeight: course.show ? screen.height / 2 : 280)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0.0, y: 20)
            .onTapGesture {
                self.course.show.toggle()
                self.active.toggle()
                if self.course.show {
                    self.activeIndex = index
                } else {
                    self.activeIndex = -1
                }
            }
            
            
        }
        .frame(height: course.show ? screen.height : 280)
        .scaleEffect(1 - activeView.width / 1000)
        .rotation3DEffect(
            .degrees(Double(self.activeView.width / 10)),
            axis: (x: 0.0, y: 1.0, z: 0.0))
        .hueRotation(.degrees(Double(self.activeView.width / 5)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            course.show ?
                DragGesture()
                .onChanged {value in
                    guard value.translation.width < 300  else { return }
                    guard value.translation.width > 0 else { return }
                    self.activeView = value.translation
                    
                }
                .onEnded {value in
                    if self.activeView.width > 50 {
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
