//
//  UIImageView+downloaded.swift
//  movieApp
//
//  Created by Casita on 5/13/20.
//  Copyright © 2020 Mattia La Spina. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
