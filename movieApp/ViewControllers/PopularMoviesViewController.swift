//
//  PopularMoviesViewController.swift
//  movieApp
//
//  Created by Casita on 5/13/20.
//  Copyright © 2020 Mattia La Spina. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet weak var popularMoviesTableView: PopularMoviesTableView!
    
    var popularMovies: [MovieData] = []
    let circularProgress: RPCircularProgress = RPCircularProgress()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.circularProgress.initialize(view: self.view)
        self.popularMoviesTableView.switchDelegateTableView = self
        
        if (NetworkManager.checkConnectivity()){
            self.circularProgress.show()
            getPopularMovies()
            self.popularMoviesTableView.setDataArray(movies: self.popularMovies)
        }else{
            showConnectionError()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.popularMoviesTableView.reloadData()
        }
    }
    
}

// -----------------------------------------------------
//MARK: PopularMoviesDelegate Implementation
// -----------------------------------------------------

extension PopularMoviesViewController: PopularMoviesDelegate {
    
    func onTap(_ PopularMovie: MovieData) {
        if (NetworkManager.checkConnectivity()){
            
             let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
             let vc = storyboard.instantiateViewController(withIdentifier:"MovieDetailViewController") as! MovieDetailViewController
            vc.movieId = String(PopularMovie.id ?? 12)
             self.present(vc, animated: true, completion: nil)
             
        }else{
            showConnectionError()
        }
    }
    
}

// -----------------------------------------------------
//MARK: Network Implementation
// -----------------------------------------------------

extension PopularMoviesViewController {
    
    fileprivate func showConnectionError() {
        let alertController = UIAlertController(title: "", message:
            "Please check your internet connection", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
        
        self.present(alertController, animated: false, completion: nil)
    }
    
    fileprivate func getPopularMovies() {
        
        if (NetworkManager.checkConnectivity()){
            
            clientApi.request(.getPopularMovies) {
                result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        switch moyaResponse.statusCode {
                        case 200:
                            
                            let response =  try moyaResponse.map(PopularMoviesResponse.self)
                            
                            self.popularMoviesTableView.setDataArray(movies: response.results ?? [])
                            DispatchQueue.main.async {
                                self.popularMoviesTableView.reloadData()
                                self.circularProgress.dismiss()
                            }
                            
                        default:
                            self.showConnectionError()
                            self.circularProgress.dismiss()
                            print(moyaResponse.statusCode)
                        }
                    }catch let error {
                        self.showConnectionError()
                        self.circularProgress.dismiss()
                        print(error)
                    }
                case let .failure(error):
                    self.showConnectionError()
                    self.circularProgress.dismiss()
                    print(error)
                }
            }
        }else{
            showConnectionError()
            self.circularProgress.dismiss()
        }
    }
    
}
