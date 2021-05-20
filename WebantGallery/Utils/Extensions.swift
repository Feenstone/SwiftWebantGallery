//
//  Extensions.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 14.05.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func setUpNavBar(with text: String) {
        let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 44.0))
        
        let label = UILabel(frame: CGRect(x: 0.0, y: -5.0, width: 100.0, height: 44.0))
        label.text = text
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textColor = UIColor(red: 0.184, green: 0.09, blue: 0.40, alpha: 1.00)
        label.textAlignment = NSTextAlignment.left
        customView.addSubview(label)
        
        let leftButton = UIBarButtonItem(customView: customView)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.leftBarButtonItem = leftButton
        
        var backImage = UIImage(systemName: "arrow.backward")
        backImage = resizeImage(image: backImage!, newWidth: 26)
        UINavigationBar.appearance().backIndicatorImage = backImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    fileprivate func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight+5))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
