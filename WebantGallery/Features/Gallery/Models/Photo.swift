//
//  Image.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 11.05.2021.
//

import Foundation

struct Photo: Codable{
    var id: Int
    var name: String
    var description: String
    var image: Image
}

struct Image: Codable {
    var id: Int
    var name: String
}
