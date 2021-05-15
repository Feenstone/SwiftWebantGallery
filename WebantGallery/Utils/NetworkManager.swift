//
//  NetworkManager.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 11.05.2021.
//

import Foundation
import RxSwift
import Alamofire

class NetworkManager<T: Decodable> {
    func fetchPhotoArray(with url: URLRequest) -> Observable<T> {
        return Observable.create { (observer) in
            let request = AF.request(url).responseDecodable{ (response: DataResponse<T, AFError>) in
                switch response.result{
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(APIError(message: "Forbidden"))
                    case 404:
                        observer.onError(APIError(message: "Not Found"))
                    case 409:
                        observer.onError(APIError(message: "Conflict"))
                    case 500:
                        observer.onError(APIError(message: "Internal Server Error"))
                    default:
                        observer.onError(APIError(message: error.localizedDescription))
                    }
                }
                
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
