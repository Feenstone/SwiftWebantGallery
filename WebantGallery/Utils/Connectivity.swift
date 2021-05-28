//
//  Connectivity.swift
//  WebantGallery
//
//  Created by IVAN KHRAMOV on 25.05.2021.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
