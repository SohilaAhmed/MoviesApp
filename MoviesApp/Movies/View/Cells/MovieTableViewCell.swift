//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 16/11/2023.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieRate: UILabel! 
    @IBOutlet weak var moviewName: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var moviewChar: UILabel!
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        desginView(view: cellView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) 
    }
    
    func setupCell(moviewName: String, movieImg: String, movieYear: String, movieRate: String){
        self.moviewName.text = moviewName
        self.movieImg.kf.setImage(with: URL(string:(movieImg).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""), placeholder: UIImage(named: "appstore"))
        self.movieYear.text = movieYear
        self.movieRate.text = movieRate.isEmpty ? "Good" : movieRate
    }
    
    func setUpMovieDetails(movieType: String, moviewChar: String){
        self.movieType.text = movieType.isEmpty ? "Movie" : movieType
        self.moviewChar.text = moviewChar
        
    }

    func desginView(view: UIView){
        view.layer.borderColor = UIColor(hexString: "#EFEFEF")?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.5
        self.movieImg.layer.cornerRadius = 8
    }
}
