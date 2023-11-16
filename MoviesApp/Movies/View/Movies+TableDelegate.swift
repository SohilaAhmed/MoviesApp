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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        return cell
    }
    
    
}
