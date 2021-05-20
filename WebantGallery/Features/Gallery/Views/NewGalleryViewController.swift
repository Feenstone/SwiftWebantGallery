//
//  ViewController.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 11.05.2021.
//

import UIKit
import Alamofire
import Kingfisher

class GalleryViewController: UIViewController {
    var presenter: ViewToPresenterPhotoProtocol?
    var builder: GalleryRequestBuilder?
    var service: APIService?
    
    
    @IBOutlet var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    
    let reuseIdentifier = "customCVCell"
    
    
    @objc func refresh() {
        presenter?.refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpNavBar(with: "New")
    
        self.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.setupPresenterIfNeed()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func setupPresenterIfNeed() {
        self.service = APIService()
        self.collectionView.backgroundColor = UIColor.white
        if self.presenter == nil {
            let presenter = GalleryPresenter(newOrPopularChooser: service!.fetchNewPhotos)
            presenter.view = self
            self.presenter = presenter
            self.builder = GalleryRequestBuilder()
        }
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.cellSetup(photo: (self.presenter?.photos[indexPath.item])!)
        
        if indexPath.row == (self.presenter?.photos.count)! - 1 {
            self.presenter?.fetchPhotos()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? PhotoDetailViewController,
           let index = collectionView.indexPathsForSelectedItems?.first {
            destination.modalPresentationStyle = .custom
            destination.photo = self.presenter?.photos[index.row]
            
        }
        
    }
}

extension GalleryViewController: PresenterToViewPhotoProtocol{
    func onFetchPhotoSuccess() {
        self.collectionView.reloadData()
        self.collectionView!.collectionViewLayout.invalidateLayout()
        self.collectionView!.layoutSubviews()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchPhotoFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        self.collectionView.refreshControl?.endRefreshing()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "NoInternetConnectionVC")
        controller.modalPresentationStyle = .custom
        self.present(controller, animated: true)
    }
    
    
}

