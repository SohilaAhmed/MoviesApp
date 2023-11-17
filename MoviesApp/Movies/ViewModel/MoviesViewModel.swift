//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 17/11/2023.
//

import Foundation


protocol AllMoviesViewModelProtocol: AnyObject{
    var bindallMovies: (() -> ())? { get set }
    var bindSearchedMovies: (() -> ())? { get set }
//    var allMovies: MoviesModel? { get }
    var searchedMovies: [MovieResult]? { get }
    func getAllMovies(pageNum: String)
    func searchMovie(searchText: String)
}

class AllMoviesViewModel: AllMoviesViewModelProtocol{
    
    var bindallMovies: (() -> ())?
    var bindSearchedMovies: (()->())?
    var pageNum: Int = 0
    var allMovies: MoviesModel?{
        didSet{
            bindallMovies?()
        }
    }
    var searchedMovies: [MovieResult]?{
        didSet{
            bindSearchedMovies?()
        }
    }
     
    func getAllMovies(pageNum: String){
        NetworkService.getApi(endPoint: EndPoints.allMovies(pageNum: pageNum)) { [weak self] (data: MoviesModel?, error) in
            guard let responsData = data else{ return}
            self?.allMovies = responsData
            self?.searchedMovies = self?.allMovies?.data?.results
            print(self?.allMovies?.data?.results?.count ?? 0)
        }
    }
    
    func searchMovie(searchText: String){
        if(!searchText.isEmpty && !searchText.trimmingCharacters(in: .whitespaces).isEmpty) {
            searchedMovies = searchedMovies?.filter{$0.title?.lowercased().contains(searchText.lowercased()) ?? false}
        }else{
            searchedMovies = allMovies?.data?.results
        }
    }
    
    
}
