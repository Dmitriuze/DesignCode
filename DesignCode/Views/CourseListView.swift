//
//  CourseListView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//
import SDWebImageSwiftUI
import SwiftUI

struct CourseListView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject private var courseListVM = CourseListViewModel()
    @State private var active = false
    @State private var activeIndex: Int = -1
    @State private var activeView = CGSize.zero
    
    var body: some View {
        
        GeometryReader { bounds in
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
                            .blur(radius: active ? 10 : 0)
                        ForEach(courseListVM.courses.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                
                                CourseView(
                                    course: $courseListVM.courses[index],
                                    active: $active,
                                    activeIndex: $activeIndex,
                                    activeView: $activeView,
                                    index: index,
                                    bounds: bounds
                                )
                                .offset(y: courseListVM.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)                            }
                                .frame(height: horizontalSizeClass == .regular ? 80 : 280)
                                .frame(maxWidth: courseListVM.courses[index].show ? 712 : getCardSize(bounds: bounds), maxHeight: .infinity)
                                .zIndex(courseListVM.courses[index].show ? 1 : 0)
                        }
                    }.frame(width: bounds.size.width)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
            }
        }
    }
}

func getCardSize(bounds: GeometryProxy) -> CGFloat {
    bounds.size.width > 712 ? 712 : bounds.size.width - 60
}
func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {
    bounds.size.width < 712 && bounds.safeAreaInsets.top < 44 ? 0: 30
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
    var bounds: GeometryProxy
    
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
            .clipShape(RoundedRectangle(cornerRadius: course.show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
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
                CourseDetailView(course: $course, active: $active, activeIndex: $activeIndex, activeView: $activeView, bounds: bounds)
                    .background(Color.background3)
                    .cornerRadius(30)
            }
            
            
        }
        .frame(height: course.show ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280)
        .scaleEffect(1 - activeView.width / 1000)
        .rotation3DEffect(
            .degrees(Double(self.activeView.width / 10)),
            axis: (x: 0.0, y: 1.0, z: 0.0))
        //        .hueRotation(.degrees(Double(self.activeView.width / 5)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        
        .edgesIgnoringSafeArea(.all)
        
    }
    
}
