//
//  MovieUseCase.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 19/11/2023.
//

import Foundation
import UIKit

protocol MovieUseCaseProtocol{
    func getMovies(vc: UIViewController, pageNum: String, completionHandeler: @escaping (((MoviesModel?), Error?)->Void))
    func getMovieById(vc: UIViewController, movieId: String, completionHandeler: @escaping (((MoviesModel?), Error?)->Void))
    func getMovieDesc() -> [MovieDescModel]
    func saveMovieDesc(movieChara: String, movieId: Int, movieType: String)
}

class MovieUseCase: MovieUseCaseProtocol{
    
    func getMovies(vc: UIViewController, pageNum: String, completionHandeler: @escaping (((MoviesModel?), Error?)->Void)){
        NetworkService.getApi(vc: vc, endPoint: EndPoints.allMovies(pageNum: pageNum)) { (data: MoviesModel?, error) in
            completionHandeler(data, error)
        }
    }
    
    func getMovieById(vc: UIViewController, movieId: String, completionHandeler: @escaping (((MoviesModel?), Error?)->Void)){
        NetworkService.getApi(vc: vc, endPoint: EndPoints.movieByID(movieID: movieId)) { (data: MoviesModel?, error) in
            completionHandeler(data, error)
        }
    }
    
    func getMovieDesc() -> [MovieDescModel]{
        CoreDataManager.fetchFromCoreData()
    }
    
    func saveMovieDesc(movieChara: String, movieId: Int, movieType: String){
        CoreDataManager.saveToCoreData(movieChara: movieChara, movieId: movieId, movieType: movieType)
    }
}
