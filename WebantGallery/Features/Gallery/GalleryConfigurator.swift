//
//  GalleryConfigurator.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 18.05.2021.
//

import Foundation
import UIKit
import RxSwift

class GalleryConfigurator {
    let service = APIService()
    static let storyboard = UIStoryboard(name: "GalleryCollectionView", bundle: .main)
    
    func configure(view: GalleryViewController, newOrPopularChooser: @escaping (_ page: Int) -> Observable<Response>, title: String) {
        let presenter = GalleryPresenter(newOrPopularChooser: newOrPopularChooser)
        view.presenter = presenter
        view.collectionTitle = title
        view.presenter?.view = view
    }

    static func createViewController(navigationController: UINavigationController, newOrPopularChooser: @escaping (_ page: Int) -> Observable<Response>, title: String){
        let view = getVC()
        navigationController.viewControllers = [view]
        GalleryConfigurator().configure(view: view, newOrPopularChooser: newOrPopularChooser, title: title)
    }

    static func getVC() -> GalleryViewController {
        let view = storyboard.instantiateViewController(identifier: "GalleryCollectionView") as! GalleryViewController 
        return view
    }
}
