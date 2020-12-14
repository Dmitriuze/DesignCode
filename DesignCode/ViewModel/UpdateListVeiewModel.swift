//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 14.12.2020.
//

import SwiftUI
import Combine

class UpdateListVeiewModel: ObservableObject {
    
    @Published var updates: [Update]
    
    init() {
        self.updates = Update.getAll()
    }
    
    func deleteData(for offset: IndexSet) {
        self.updates.remove(atOffsets: offset)
    }
    
    func moveData(from offset: IndexSet, to destination: Int) {
        self.updates.move(fromOffsets: offset, toOffset: destination)
    }
    

}
