//
//  Extensions.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 14.05.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func setUpNavBar() {
        var backImage = UIImage(systemName: "arrow.backward")
        backImage = resizeImage(image: backImage!, newWidth: 26)
        UINavigationBar.appearance().backIndicatorImage = backImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    fileprivate func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
