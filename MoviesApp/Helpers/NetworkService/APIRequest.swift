//
//  APIRequest.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 17/11/2023.
//

import Foundation
import NVActivityIndicatorView

private let BASE_URL = "http://gateway.marvel.com/v1/public/"

protocol Service{
    static func getApi<T: Decodable>(vc: UIViewController, endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void)
}

class NetworkService : Service{
    
    static func getApi<T: Decodable>(vc: UIViewController, endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void){
        
        let frame = CGRect(x: vc.view.frame.width / 2 , y: vc.view.frame.height / 2, width: 0, height: 0)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                            type: .ballScale)
        activityIndicatorView.color = UIColor.darkGray
        activityIndicatorView.padding = 100
        vc.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
         
        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        guard let url = url else{ return }
        var req = URLRequest(url: url)
        req.httpMethod = "GET" 
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, response, error in
            DispatchQueue.main.async {  
                activityIndicatorView.stopAnimating()
            }
            if let error = error{
                print(error.localizedDescription)
                completionHandeler(nil, error)
            }else{
                guard let data = data else {
                    print(String(describing: error))
                    return
                  }
                let res = try? JSONDecoder().decode(T.self, from: data)
                print(String(data: data, encoding: .utf8)!)
                completionHandeler(res, nil)
            }
            
        }
        task.resume()
    }
    

}

