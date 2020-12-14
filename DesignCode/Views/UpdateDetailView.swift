//
//  UpdateDetailView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 14.12.2020.
//

import SwiftUI

struct UpdateDetailView: View {
    
    var update: Update
    
    var body: some View {
        List {
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
            }
            .navigationBarTitle(Text(update.title))
            
        }.listStyle(PlainListStyle())
    }
}

struct UpdateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetailView(update: Update.getAll()[0])
    }
}
