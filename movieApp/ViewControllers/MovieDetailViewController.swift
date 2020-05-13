//
//  MovieDetailViewController.swift
//  movieApp
//
//  Created by Casita on 5/13/20.
//  Copyright © 2020 Mattia La Spina. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
        
    @IBOutlet weak var ImageHeader: UIImageView!
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var durationTime: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    
    
    var movieId: String = "12";
    let circularProgress: RPCircularProgress = RPCircularProgress()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.circularProgress.initialize(view: self.view)
        
        if (NetworkManager.checkConnectivity()){
            self.circularProgress.show()
            getMovieDetail()
            
        }else{
            showConnectionError()
        }
        
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// -----------------------------------------------------
//MARK: Network Implementation
// -----------------------------------------------------

extension MovieDetailViewController {
    
    fileprivate func showConnectionError() {
        let alertController = UIAlertController(title: "", message:
            "Please check your internet connection", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
        
        self.present(alertController, animated: false, completion: nil)
    }
    
    fileprivate func getMovieDetail() {
        
        if (NetworkManager.checkConnectivity()){
            
            clientApi.request(.getMovieDetails(id: movieId)) {
                result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        switch moyaResponse.statusCode {
                        case 200:
                            
                            let response =  try moyaResponse.map(DetailMovieResponse.self)
                            
                            self.titleHeader.text = response.originalTitle ?? ""
                            self.releaseDate.text = response.releaseDate ?? ""
                            self.durationTime.text = String(response.runtime ?? 0) + "min"
                            self.movieDescription.text = response.overview
                            
                            self.ImageHeader.downloaded(from: (NetworkConstants.URL_IMAGES + (response.backdropPath ?? "")))
                            
                            DispatchQueue.main.async {
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
