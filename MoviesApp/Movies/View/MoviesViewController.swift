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
      
    var allMoviesViewModelProtocol: AllMoviesViewModelProtocol = AllMoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchDesign(textField: searchTF)
        desginTFView(view: searchView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allMoviesViewModelProtocol.bindallMovies = { [weak self] in

            print(self?.allMoviesViewModelProtocol.allMovies?.data?.results?[1].title ?? "")
//            self?.allCoupon = self?.presentAllCouponViewModel.allCouponPriceRule.price_rules ?? []
            DispatchQueue.main.async { [weak self] in
                self?.moviesTableView.reloadData()
            }
            
        }
        
        allMoviesViewModelProtocol.getAllMovies(pageNum: "0")
    }
    
    @IBAction func searchTFAction(_ sender: UITextField) {
        if let searchText = sender.text {
            if(!searchText.isEmpty && !searchText.trimmingCharacters(in: .whitespaces).isEmpty) {
//                serchedProducts = arrOfProducts?.filter{$0.product_name?.lowercased().contains(searchText.lowercased()) ?? false}
            }else{
//                serchedProducts = arrOfProducts
            }
            moviesTableView.reloadData()
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
