//
//  PhotoContract.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 12.05.2021.
//

import Foundation

protocol ViewToPresenterPhotoProtocol {
    var view: PresenterToViewPhotoProtocol? { get set }
    var photos: [Photo] { get }
    func viewDidLoad()
    func refresh()
    func fetchPhotos()
}

protocol PresenterToViewPhotoProtocol {
    func onFetchPhotoSuccess()
    func onFetchPhotoFailure(error: String)
}
