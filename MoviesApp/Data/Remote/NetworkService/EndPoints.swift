//
//  EndPoints.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 17/11/2023.
//

import Foundation

enum EndPoints {
    case allMovies(pageNum: String)
    case movieByID(movieID: String)
    
    var path:String{
        switch self {
        case .allMovies(pageNum: let pageNum):
            return "series?ts=1&apikey=c9a894ed4026010d919952290204ee1c&hash=49358250921c96aa2c6099d7d95e1bcc&limit=15&offset=\(pageNum)"
        case .movieByID(movieID: let movieID):
            return "series/\(movieID)?ts=1&apikey=c9a894ed4026010d919952290204ee1c&hash=49358250921c96aa2c6099d7d95e1bcc"
        }
    }
        
}
