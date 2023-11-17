//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 16/11/2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieRate: UILabel! 
    @IBOutlet weak var moviewName: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var moviewChar: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        desginView(view: cellView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(moviewName: String, movieImg: String, movieYear: String, movieRate: String){
        self.moviewName.text = moviewName
        self.movieImg.image = UIImage(named: "appstore")
        self.movieYear.text = movieYear
        if movieRate == ""{
            self.movieRate.text = "Good"
        }else{
            self.movieRate.text = movieRate
        }
    }
    
    func setUpMovieDetails(movieType: String, moviewChar: String){
        self.movieType.text = movieType
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
    }
}
