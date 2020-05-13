//
//  NetworkConstants.swift
//  movieApp
//
//  Created by Mattia La Spina on 5/12/20.
//  Copyright © 2020 Mattia La Spina. All rights reserved.
//

class NetworkConstants {
    
    static let PROTOCOL: String = "https://"
    static let DOMAIN: String = "api.themoviedb.org"
    
    static let URL_BASE: String = PROTOCOL + DOMAIN

    static let MOVIE_ENDPOINT: String = "/3/movie"

    static let POPULAR_MOVIE_ENDPOINT: String = MOVIE_ENDPOINT + "/popular"
    static let DETAIL_MOVIE_ENDPOINT: String = MOVIE_ENDPOINT + "/"
    
    static let API_KEY: String = "6940c3b8565bd12997d02f612cf9c8a7"
    
    static let URL_IMAGES: String = "https://image.tmdb.org/t/p/w500/"

}
