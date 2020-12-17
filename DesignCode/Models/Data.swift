//
//  Data.swift
//  DesignCode
//
//  Created by Dmitry Bulykin on 17.12.2020.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: Int
    var title: String
    var body: String
}

