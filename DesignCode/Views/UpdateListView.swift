//
//  UpdateView.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 14.12.2020.
//

import SwiftUI

struct UpdateListView: View {
    
    @ObservedObject private var updateListVM = UpdateListVeiewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(updateListVM.updates) {update in
                    NavigationLink(destination: UpdateDetailView(update: update)) {
                        HStack {
                            Image(update.image)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(update.title)
                                    .font(.system(size: 20, weight: .bold))
                                Text(update.text)
                                    .lineLimit(2)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(update.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }.padding(.vertical, 4)
                    }
                }
                .onDelete(perform: { indexSet in
                    self.updateListVM.deleteData(for: indexSet)
                })
                .onMove(perform: { indexSet, destination in
                    self.updateListVM.moveData(from: indexSet, to: destination)
                })
            }
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(leading: EditButton(), trailing:  Button(action: {}, label: {Image(systemName: "plus")}))
        }
    }
}

struct UpdateListView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateListView()
    }
}

