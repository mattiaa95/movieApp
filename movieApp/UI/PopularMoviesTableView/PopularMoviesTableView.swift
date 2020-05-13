//
//  PopularMoviesTableView.swift
//  movieApp
//
//  Created by Mattia La Spina on 5/13/20.
//  Copyright © 2020 Mattia La Spina. All rights reserved.
//

import UIKit

class PopularMoviesTableView : UITableView, UITableViewDelegate {
    
    var popularMovies: [MovieData] = []
    var itemViewName : String = "PopularMoviesTableViewCell"
    var switchDelegateTableView: PopularMoviesDelegate?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setUp(itemViewName: itemViewName)
    }
    
    func setUp(itemViewName: String) {
        self.dataSource = self
        self.delegate = self
        let nib = UINib.init(nibName: itemViewName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: itemViewName)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switchDelegateTableView?.onTap(popularMovies[indexPath.row])
        return nil
    }
    
    func setDataArray(movies : [MovieData]) {
        self.popularMovies = movies
    }

}

protocol PopularMoviesDelegate: class {
    func onTap(_ PopularMovie: MovieData)
}

extension PopularMoviesTableView :UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemViewName, for: indexPath) as! PopularMoviesTableViewCell
        let movieData: MovieData = self.popularMovies[indexPath.row]
        
        cell.Title.text = movieData.title ?? ""
        cell.Score.text = String(movieData.voteAverage ?? 0) + "/10"
        cell.Year.text = String((movieData.releaseDate ?? "2000").prefix(4))
        
        cell.PosterImage.downloaded(from: (NetworkConstants.URL_IMAGES + (movieData.posterPath ?? "")))

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.popularMovies.count
    }
    
}
