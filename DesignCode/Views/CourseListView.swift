//
//  CourseListView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//
import SDWebImageSwiftUI
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
                                activeIndex: $activeIndex,
                                activeView: $activeView,
                                index: index
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
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    var index: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 20){
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .lineLimit(2)
                        Text(course.subtitle)
                            .opacity(0.7)
                    }
                    Spacer()
                    Image(uiImage: course.logo).opacity(course.show ? 0 : 1)
                    
                }.foregroundColor(Color.white)
                Spacer()
                
                WebImage(url: course.image, isAnimating: .constant(true))
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
            .onTapGesture {
                self.course.show.toggle()
                self.active.toggle()
                if self.course.show {
                    self.activeIndex = index
                } else {
                    self.activeIndex = -1
                }
            }
            
            if course.show {
                CourseDetailView(course: $course, active: $active, activeIndex: $activeIndex, activeView: $activeView)
                    .background(Color.white)
                    .cornerRadius(30)
            }
            
            
        }
        .frame(height: course.show ? screen.height : 280)
        .scaleEffect(1 - activeView.width / 1000)
        .rotation3DEffect(
            .degrees(Double(self.activeView.width / 10)),
            axis: (x: 0.0, y: 1.0, z: 0.0))
//        .hueRotation(.degrees(Double(self.activeView.width / 5)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        
        .edgesIgnoringSafeArea(.all)
        
    }
    
}
