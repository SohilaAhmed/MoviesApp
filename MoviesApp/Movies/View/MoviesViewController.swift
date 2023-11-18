//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 15/11/2023.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var moviesTableView: UITableView!
    
    var moviesViewModelProtocol: MoviesViewModelProtocol = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchDesign(textField: searchTF)
        desginTFView(view: searchView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        moviesViewModelProtocol.bindallMovies = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.moviesTableView.reloadData()
            }
        }
        moviesViewModelProtocol.getAllMovies(vc: self, pageNum: "0") 
    }
    
    @IBAction func searchTFAction(_ sender: UITextField) {
        if let searchText = sender.text {
            moviesViewModelProtocol.bindSearchedMovies = { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.moviesTableView.reloadData()
                }
            }
            moviesViewModelProtocol.searchMovie(searchText: searchText)
        }
    }
    
}

extension MoviesViewController{
    func searchDesign(textField: UITextField){
        textField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 15, y: 6, width: 20, height: 20))
        let image = UIImage(named: "Search")
        imageView.image = image
        
        let view = UIView(frame: CGRect(x: textField.frame.origin.x , y: 0, width: 48, height: textField.frame.height))
        view.addSubview(imageView)
        textField.leftView = view
    }
    
    func desginTFView(view: UIView){
        view.layer.borderColor = UIColor(hexString: "#EFEFEF")?.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
    }
}
