//
//  PhotoDetailViewController.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 15.05.2021.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    var photo: Photo?
    var builder: GalleryRequestBuilder?

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        // Do any additional setup after loading the view.
    }
    
    func setupVC() {
        self.builder = GalleryRequestBuilder()
        
        print(self.photo as Any)
        print(builder?.createImageUrl(name: (self.photo?.image.name)!) as Any)
        
        self.imageView.kf.setImage(with: builder?.createImageUrl(name: (self.photo?.image.name)!))
        
        self.nameLabel.text = self.photo?.name
        self.descriptionLabel.numberOfLines = 0 
        self.descriptionLabel.text = self.photo?.description
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
