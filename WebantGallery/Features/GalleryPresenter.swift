//
//  GalleryPresenter.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 11.05.2021.
//

import Foundation
import RxSwift

class GalleryPresenter: ViewToPresenterPhotoProtocol {
    var view: PresenterToViewPhotoProtocol?
    
    private let service = APIService()
    private var page = 1
    private let disposeBag = DisposeBag()
    
    var photos: [Photo] = [Photo]()
    
    func viewDidLoad() {
        fetchNewPhotos()
    }
    
    func refresh() {
        page = 1
        photos.removeAll()
        fetchNewPhotos()
    }
    
    func fetchNewPhotos() {
        service.fetchNewPhotos(page: self.page)
            .observe(on: MainScheduler.instance)
            .subscribe { (response) in
                self.photos.append(contentsOf: response.data)
                self.view?.onFetchPhotoSuccess()
            } onError: { (error) in
                print(error.localizedDescription)
            } onCompleted: {
                self.page += 1
            }.disposed(by: disposeBag)
    }
    
    func fetchPopularPhotos() {
        service.fetchNewPhotos(page: self.page)
            .observe(on: MainScheduler.instance)
            .subscribe{ (response) in
                self.photos.append(contentsOf: response.data)
                self.view?.onFetchPhotoSuccess()
            } onError: { (error) in
                print(error.localizedDescription)
            } onCompleted: {
                self.page += 1
            }
    }
}
