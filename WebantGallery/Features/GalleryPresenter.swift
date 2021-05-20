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
    var newOrPopularChooser: (_ page: Int) -> Observable<Response>
    
    private let service = APIService()
    private var page = 1
    private let disposeBag = DisposeBag()
    
    var photos: [Photo] = [Photo]()
    
    init(newOrPopularChooser: @escaping (_ page: Int) -> Observable<Response>) {
        self.newOrPopularChooser = newOrPopularChooser
    }
    
    func viewDidLoad() {
        fetchPhotos()
    }
    
    func refresh() {
        page = 1
        photos.removeAll()
        fetchPhotos()
    }
    
    func fetchPhotos() {
        newOrPopularChooser(self.page)
            .observe(on: MainScheduler.instance)
            .subscribe{ (response) in
                self.photos.append(contentsOf: response.data)
                self.page += 1
                self.view?.onFetchPhotoSuccess()
            } onError: { error in
                self.view?.onFetchPhotoFailure(error: error.localizedDescription)
            } onCompleted: {
            }.disposed(by: disposeBag)
    }
}
