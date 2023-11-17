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
        return allMoviesViewModelProtocol.searchedMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.setupCell(moviewName: allMoviesViewModelProtocol.searchedMovies?[indexPath.row].title ?? "",
                       movieImg: "\(allMoviesViewModelProtocol.searchedMovies?[indexPath.row].thumbnail?.path ?? "").\(allMoviesViewModelProtocol.searchedMovies?[indexPath.row].thumbnail?.thumbnailExtension?.rawValue ?? "")",
                       movieYear: "\(allMoviesViewModelProtocol.searchedMovies?[indexPath.row].startYear ?? 0)",
                       movieRate: allMoviesViewModelProtocol.searchedMovies?[indexPath.row].rating ?? "NoRate")
        return cell
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
