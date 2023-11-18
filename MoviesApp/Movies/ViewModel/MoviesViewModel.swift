//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 17/11/2023.
//

import Foundation
import UIKit


protocol MoviesViewModelProtocol: AnyObject{
    var bindallMovies: (() -> ())? { get set }
    var bindSearchedMovies: (() -> ())? { get set }
//    var allMovies: MoviesModel? { get }
    var searchedMovies: [MovieResult]? { get set}
    func getAllMovies(vc: UIViewController, pageNum: String)
    func searchMovie(searchText: String)
    var bindMovieById: (()->())? { get set }
    var movieById: MovieResult? { get set}
    func getMovieById(vc: UIViewController, movieId: String)
    func saveMovieDescInCoreData(movieChara: String, movieId: Int, movieType: String)
    func getMovieDescInCoreData(movieId: Int)
    var bindsavedMovieDesc: (()->())? { get set }
    var savedMovieDesc: MovieDescModel? { get set}
}

class MoviesViewModel: MoviesViewModelProtocol{
    
    var bindallMovies: (() -> ())?
    var allMovies: MoviesModel?{
        didSet{
            bindallMovies?()
        }
    }
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
    var bindsavedMovieDesc: (()->())?
    var savedMovieDesc: MovieDescModel?{
        didSet{
//            bindsavedMovieDesc?()
        }
    }
    var coreDataSavedMoviesDesc: [MovieDescModel]?
//    var pageNum: Int = 0
    
    
    func getAllMovies(vc: UIViewController, pageNum: String){
        NetworkService.getApi(vc: vc, endPoint: EndPoints.allMovies(pageNum: pageNum)) { [weak self] (data: MoviesModel?, error) in
            guard let responsData = data else{ return }
            self?.allMovies = responsData
            self?.searchedMovies = self?.allMovies?.data?.results
//            print(self?.allMovies?.data?.results?.count ?? 0)
        }
    }
    
    func searchMovie(searchText: String){
        if(!searchText.isEmpty && !searchText.trimmingCharacters(in: .whitespaces).isEmpty) {
            searchedMovies = searchedMovies?.filter{$0.title?.lowercased().contains(searchText.lowercased()) ?? false}
        }else{
            searchedMovies = allMovies?.data?.results
        }
    }
    
    func getMovieById(vc: UIViewController, movieId: String){
        NetworkService.getApi(vc: vc, endPoint: EndPoints.movieByID(movieID: movieId)) { [weak self] (data: MoviesModel?, error) in
            guard let responsData = data else{ return }
            self?.movieById = responsData.data?.results?.first
            print(self?.movieById?.title ?? 0)
        }
    }
    
    func saveMovieDescInCoreData(movieChara: String, movieId: Int, movieType: String){
        CoreDataManager.saveToCoreData(movieChara: movieChara, movieId: movieId, movieType: movieType)
    }
    
    func getMovieDescInCoreData(movieId: Int){
        coreDataSavedMoviesDesc = CoreDataManager.fetchFromCoreData()
        savedMovieDesc = MovieDescModel()
        if coreDataSavedMoviesDesc?.isEmpty ?? true == false{
            for i in 0..<(coreDataSavedMoviesDesc?.count ?? 0){
                if movieId == coreDataSavedMoviesDesc?[i].movieId{
                    savedMovieDesc = coreDataSavedMoviesDesc?[i] ?? MovieDescModel()
                }
            }
        }
    }
}
