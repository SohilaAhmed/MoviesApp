//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 17/11/2023.
//

import Foundation
import UIKit


protocol MoviesViewModelProtocol: AnyObject{
    var bindSearchedMovies: (() -> ())? { get set }
    var searchedMovies: [MovieResult]? { get set}
    func getAllMovies(vc: UIViewController, pageNum: String)
    func searchMovie(searchText: String)
    var bindMovieById: (()->())? { get set }
    var movieById: MovieResult? { get set}
    func getMovieById(vc: UIViewController, movieId: String)
    func saveMovieDescInCoreData(movieChara: String, movieId: Int, movieType: String)
    func getMovieDescInCoreData(movieId: Int)
    var savedMovieDesc: MovieDescModel? { get set}
    var pageNum: Int { get set}
    func setupPagination(vc: UIViewController, index: Int)
}

class MoviesViewModel: MoviesViewModelProtocol{
     
    var movieUseCaseProtocol: MovieUseCaseProtocol = MovieUseCase()
    var allMovies: [MovieResult]?
    var bindSearchedMovies: (()->())?
    var searchedMovies: [MovieResult]?{
        didSet{
            bindSearchedMovies?()
        }
    }
    var bindMovieById: (()->())?
    var movieById: MovieResult?{
        didSet{
            bindMovieById?()
        }
    }
    var savedMovieDesc: MovieDescModel?
    var coreDataSavedMoviesDesc: [MovieDescModel]?
    var pageNum: Int = 0
    var totalMovies = 0
     
    func getAllMovies(vc: UIViewController, pageNum: String){
        movieUseCaseProtocol.getMovies(vc: vc, pageNum: pageNum) { [weak self] data, error in
            guard let responsData = data else{ return }
            if pageNum == "0" {
                self?.allMovies = responsData.data?.results
            }else {
                self?.allMovies! += responsData.data?.results ?? []
            }
            self?.totalMovies = responsData.data?.total ?? 0
            self?.searchedMovies = self?.allMovies
        }
    }
    
    func searchMovie(searchText: String){
        if(!searchText.isEmpty && !searchText.trimmingCharacters(in: .whitespaces).isEmpty) {
            searchedMovies = searchedMovies?.filter{$0.title?.lowercased().contains(searchText.lowercased()) ?? false}
        }else{
            searchedMovies = allMovies
        }
    }
    
    func getMovieById(vc: UIViewController, movieId: String){
        movieUseCaseProtocol.getMovieById(vc: vc, movieId: movieId) { [weak self] data, error in
            guard let responsData = data else{ return }
            self?.movieById = responsData.data?.results?.first
        }
    }
    
    func saveMovieDescInCoreData(movieChara: String, movieId: Int, movieType: String){
        movieUseCaseProtocol.saveMovieDesc(movieChara: movieChara, movieId: movieId, movieType: movieType)
    }
    
    func getMovieDescInCoreData(movieId: Int){
        coreDataSavedMoviesDesc = movieUseCaseProtocol.getMovieDesc()
        savedMovieDesc = MovieDescModel()
        if coreDataSavedMoviesDesc?.isEmpty ?? true == false{
            for i in 0..<(coreDataSavedMoviesDesc?.count ?? 0){
                if movieId == coreDataSavedMoviesDesc?[i].movieId{
                    savedMovieDesc = coreDataSavedMoviesDesc?[i] ?? MovieDescModel()
                }
            }
        }
    }
    
    func setupPagination(vc: UIViewController, index: Int){
        guard searchedMovies != nil else {
            return
        }
        if index == (searchedMovies?.count ?? 0) - 1 {
            if searchedMovies?.count ?? 0 < totalMovies {
                pageNum += 1
                getAllMovies(vc: vc, pageNum: "\(pageNum)")
            }
            
        }
    }
}
