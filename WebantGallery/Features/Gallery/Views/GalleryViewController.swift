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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    private let footerView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    let reuseIdentifier = "customCVCell"
    var isLoadingList: Bool = false
    var collectionTitle: String?
    
    
    @objc func refresh() {
        presenter?.refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavBar()
        self.titleLabel.text = collectionTitle
        collectionView.register(CollectionViewFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 50)
        self.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList && !presenter!.isEndReached){
            footerView.startAnimating()
            self.isLoadingList = true
            self.presenter?.fetchPhotos()
        }
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        if !(presenter?.photos.isEmpty)! {
        cell.cellSetup(photo: (self.presenter?.photos[indexPath.item])!)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = 20 * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + 0 * CGFloat(2 - 1)
        let itemWidthForPortrait = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(2.04)).rounded(.down)
        let itemHeightForPortrait = ((collectionView.bounds.size.height - marginsAndInsets) / CGFloat(5.1)).rounded(.down)
        
        let itemWidthForLandscape = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(4.34)).rounded(.down)
        let itemHeightForLandscape = ((collectionView.bounds.size.height - marginsAndInsets) / CGFloat(2.1)).rounded(.down)
        
        return UIDevice.current.orientation.isPortrait ? CGSize(width: itemWidthForPortrait, height: itemHeightForPortrait) : CGSize(width: itemWidthForLandscape, height: itemHeightForLandscape)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 30, left: 17, bottom: 0, right: 17)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            footer.addSubview(footerView)
            footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
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
        footerView.stopAnimating()
        self.isLoadingList = false
        self.collectionView.reloadData()
        self.collectionView!.collectionViewLayout.invalidateLayout()
        self.collectionView!.layoutSubviews()
        self.refreshControl.endRefreshing()
        self.collectionView.backgroundView = nil
    }
    
    func onFetchPhotoFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        let storyboard = UIStoryboard(name: "NoInternetConnectionView", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "NoInternetConnectionVC")
        self.presenter?.photos = []
        self.collectionView.reloadData()
        collectionView.backgroundView = controller.view
        self.refreshControl.endRefreshing()
        footerView.stopAnimating()
    }
}

