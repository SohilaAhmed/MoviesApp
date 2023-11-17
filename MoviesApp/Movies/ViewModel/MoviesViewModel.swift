//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 17/11/2023.
//

import Foundation


protocol AllMoviesViewModelProtocol: AnyObject{
    var bindallMovies: (() -> ())? { get set }
    func getAllMovies(pageNum: String)
    var allMovies: MoviesModel? { get }
}

class AllMoviesViewModel: AllMoviesViewModelProtocol{
    
    var bindallMovies: (() -> ())?
    
    var allMovies: MoviesModel?{
        didSet{
            bindallMovies?()
        }
    }
     
    func getAllMovies(pageNum: String){
        NetworkService.getApi(endPoint: EndPoints.allMovies(pageNum: pageNum)) { [weak self] (data: MoviesModel?, error) in
            guard let responsData = data else{ return}
            self?.allMovies = responsData
            print(self?.allMovies?.data?.results?.count ?? 0)
        }
    }
}
