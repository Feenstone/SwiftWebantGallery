//
//  PhotoCollectionViewCell.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 11.05.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var builder = GalleryRequestBuilder()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.isUserInteractionEnabled = false
        // Initialization code
    }

    @objc func navigateToDetailView() {
        
    }
    
    func cellSetup(photo: Photo) {
        self.imageView.kf.setImage(with: builder.createImageUrl(name: photo.image.name))
        self.imageView.layer.cornerRadius = 8
        
        self.contentView.layer.cornerRadius = 8
        
        self.layer.borderColor = UIColor.opaqueSeparator.cgColor
        self.layer.borderWidth = 1

        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 0.0
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = false
    }
}
