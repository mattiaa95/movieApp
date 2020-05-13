//
//  Client.swift
//  movieApp
//
//  Created by Mattia La Spina on 5/12/20.
//  Copyright © 2020 Mattia La Spina. All rights reserved.
//

import Moya

enum Client {
    case getPopularMovies
    case getMovieDetails(id: String)
}

extension Client: TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: ["api_key": NetworkConstants.API_KEY],
            encoding: URLEncoding.queryString);
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var baseURL: URL {
            return URL(string: NetworkConstants.URL_BASE)!
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return NetworkConstants.POPULAR_MOVIE_ENDPOINT
            
        case let .getMovieDetails(id):
            return NetworkConstants.DETAIL_MOVIE_ENDPOINT + id
            
        }
    }
    
    var method: Moya.Method {
        return .get
    }
}
