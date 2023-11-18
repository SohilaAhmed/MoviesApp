//
//  Home+TableDelegate.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 15/11/2023.
//

import Foundation
import UIKit

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModelProtocol.searchedMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.setupCell(moviewName: moviesViewModelProtocol.searchedMovies?[indexPath.row].title ?? "",
                       movieImg: "\(moviesViewModelProtocol.searchedMovies?[indexPath.row].thumbnail?.path ?? "").\(moviesViewModelProtocol.searchedMovies?[indexPath.row].thumbnail?.thumbnailExtension?.rawValue ?? "")",
                       movieYear: "\(moviesViewModelProtocol.searchedMovies?[indexPath.row].startYear ?? 0)",
                       movieRate: moviesViewModelProtocol.searchedMovies?[indexPath.row].rating ?? "")
        
        let selectState = moviesViewModelProtocol.searchedMovies?[indexPath.row].selected ?? false
        if selectState{
            cell.descView.isHidden = false
            
            moviesViewModelProtocol.getMovieDescInCoreData(movieId: moviesViewModelProtocol.searchedMovies?[indexPath.row].id ?? 0)
            
            cell.setUpMovieDetails(movieType: self.moviesViewModelProtocol.savedMovieDesc?.movieType ?? " ",
                                   moviewChar: self.moviesViewModelProtocol.savedMovieDesc?.movieChara ?? "")
        }else{
            cell.descView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moviesCount = moviesViewModelProtocol.searchedMovies?.count ?? 0
        if moviesViewModelProtocol.searchedMovies?[indexPath.row].selected == true{
            for i in 0 ..< moviesCount{
                moviesViewModelProtocol.searchedMovies?[i].selected = false
            }
        }else{
            for i in 0 ..< moviesCount{
                moviesViewModelProtocol.searchedMovies?[i].selected = false
            }
            moviesViewModelProtocol.searchedMovies?[indexPath.row].selected = true
        }
        moviesTableView.reloadData()
        
        if UserDefaults.standard.string(forKey: "\(moviesViewModelProtocol.searchedMovies?[indexPath.row].id ?? 0)") == nil{
            moviesViewModelProtocol.getMovieById(vc: self, movieId: "\(moviesViewModelProtocol.searchedMovies?[indexPath.row].id ?? 0)")
            moviesViewModelProtocol.bindMovieById = { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    var movieCharas = ""
                    if self?.moviesViewModelProtocol.movieById?.characters?.available ?? 0 > 0{
                        for i in 0..<(self?.moviesViewModelProtocol.movieById?.characters?.items?.count ?? 0) {
                            movieCharas += "\(self?.moviesViewModelProtocol.movieById?.characters?.items?[i].name ?? ""),"
                        }
                    }else{
                        movieCharas = "Not Available"
                    }
                    print(self?.moviesViewModelProtocol.movieById?.id ?? 0)
                    self?.moviesViewModelProtocol.saveMovieDescInCoreData(movieChara: movieCharas,
                                                                          movieId: self?.moviesViewModelProtocol.movieById?.id ?? 0,
                                                                          movieType: self?.moviesViewModelProtocol.movieById?.type ?? "")
                    self?.moviesTableView.reloadData()
                }
            }
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        guard allMoviesViewModelProtocol.allMovies?.data?.results != nil else {
    //            // Data is empty or nil
    //            return
    //        }
    ////        if indexPath.row == (moviesData?.count ?? 0) - 1 {
    ////            if Int(allMoviesViewModelProtocol.allMovies?.data?.offset ?? 0) ?? 00 < moviesData?. ?? 0 {
    ////                pageNo += 1
    ////                print("xxxxxxxxxxxxxxxxxxx\(pageNo)")
    ////                getOrder()
    ////              }
    ////
    ////        }
    //    }
}
