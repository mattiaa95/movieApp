//
//  NetworkManager.swift
//  movieApp
//
//  Created by Casita on 5/13/20.
//  Copyright © 2020 Mattia La Spina. All rights reserved.
//
//

import Foundation
import Alamofire

class NetworkManager {
    class func checkConnectivity() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
