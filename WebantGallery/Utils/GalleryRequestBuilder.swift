//
//  GalleryRequestBuilder.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 11.05.2021.
//

import Foundation
import Alamofire

class GalleryRequestBuilder {
    let endPoint: String = "http://gallery.dev.webant.ru/api/photos"
    let photoEndPoint: String = "http://gallery.dev.webant.ru/media/"
    
    func fetchNewImages(page: Int) -> URLRequest {
        let url = endPoint
        let parameters : Parameters = [
            "new": "true",
            "page": page,
            "limit": "10"
        ]
        return try! URLEncoding.default.encode(URLRequest(url: url, method: .get), with: parameters)
    }
    
    func createImageUrl(name: String) -> URL {
        let galleryEndPoint = photoEndPoint + name
        
        return URL(string: galleryEndPoint)!
    }
    
    func fetchPopularImages(page: Int) -> URLRequest {
        let url = endPoint
        let parameters : Parameters = [
            "popular": "true",
            "page": page,
            "limit": 10
        ]
        return try! URLEncoding.default.encode(URLRequest(url: url, method: .get), with: parameters)
    }
}
