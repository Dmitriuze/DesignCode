//
//  CourseListView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 15.12.2020.
//

import SwiftUI

struct CourseListView: View {
    
    @State private var show = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20){
                    Text("SwiftUI Advanced")
                        .font(.system(size: 24, weight: .bold))
                    Text("20 sections")
                        .opacity(0.7)
                }
                Spacer()
                Image("Logo1")
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
        .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280)
        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 20, x: 0.0, y: 20)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onTapGesture {
            self.show.toggle()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseListView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}
