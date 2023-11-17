//
//  APIRequest.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 17/11/2023.
//

import Foundation

private let BASE_URL = "http://gateway.marvel.com/v1/public/"

protocol Service{
    static func getApi<T: Decodable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void)
}

class NetworkService : Service{
     
    static func getApi<T: Decodable>(endPoint: EndPoints, completionHandeler: @escaping ((T?), Error?) -> Void){
        
        let path = "\(BASE_URL)\(endPoint.path)"
        let url = URL(string: path)
        guard let url = url else{ return }
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
//        req.addValue("c9a894ed4026010d919952290204ee1c", forHTTPHeaderField: "apikey")
//        req.addValue("49358250921c96aa2c6099d7d95e1bcc", forHTTPHeaderField: "hash")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, response, error in
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

