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
        return allMoviesViewModelProtocol.allMovies?.data?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.setupCell(moviewName: allMoviesViewModelProtocol.allMovies?.data?.results?[indexPath.row].title ?? "",
                       movieImg: "\(allMoviesViewModelProtocol.allMovies?.data?.results?[indexPath.row].thumbnail?.path ?? "").\(allMoviesViewModelProtocol.allMovies?.data?.results?[indexPath.row].thumbnail?.thumbnailExtension?.rawValue ?? "")",
                       movieYear: "\(allMoviesViewModelProtocol.allMovies?.data?.results?[indexPath.row].startYear ?? 0)",
                       movieRate: allMoviesViewModelProtocol.allMovies?.data?.results?[indexPath.row].rating ?? "NoRate")
        return cell
    }
    
    
}
