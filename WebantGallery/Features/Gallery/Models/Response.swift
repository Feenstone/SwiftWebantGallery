//
//  Response.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 11.05.2021.
//

import Foundation
struct Response : Codable {
    var totalItems: Int
    var itemsPerPage: Int
    var countOfPages: Int
    var data: [Photo]
    
}
