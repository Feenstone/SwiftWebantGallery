//
//  GalleryConfigurator.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 18.05.2021.
//

import Foundation
import UIKit

class GalleryConfigurator {
    let service = APIService()
    
    func configureNew(view: GalleryViewController) {
        let presenter = GalleryPresenter(newOrPopularChooser: service.fetchNewPhotos)
        view.presenter = presenter
    }

    static func open(navigationController: UINavigationController) {
//        let view = GalleryConfigurator.getVC()
//        GalleryConfigurator().configureNew(view: view)
//        navigationController.pushViewController(view, animated: true)
    }

//    static func getVC() -> NewGalleryViewController {
//        guard let view = R.storyboard.firstStoryboard.instantiateInitialViewController() else {
//            return FirstViewController()
//        }
//        return view
//    }
}
