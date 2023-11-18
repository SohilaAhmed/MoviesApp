//
//  CoreDataService.swift
//  MoviesApp
//
//  Created by Sohila Ahmed on 17/11/2023.
//

import Foundation
import CoreData
import UIKit


protocol CoreDataManagerProtocol: AnyObject{
    static func saveToCoreData(movieChara: String, movieId: Int, movieType: String)
    static func fetchFromCoreData() ->[MovieDescModel]
}

class CoreDataManager: CoreDataManagerProtocol {
    static var context : NSManagedObjectContext?
    static var appDelegate : AppDelegate?
    
    static func saveToCoreData(movieChara: String, movieId: Int, movieType: String){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        
        guard let myContext = context else{return}
        let entity = NSEntityDescription.entity(forEntityName: "MovieDesc", in: myContext)
        guard let myEntity = entity else{return}
        do{
            let movieDesc = NSManagedObject(entity: myEntity, insertInto: myContext)
            movieDesc.setValue(movieChara, forKey: "movieChara")
            movieDesc.setValue(movieId, forKey: "movieId")
            movieDesc.setValue(movieType, forKey: "movieType")
            print("Saved Successfully")
            UserDefaults.standard.set("true", forKey: "\(movieId)")
            try myContext.save()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    static func fetchFromCoreData() ->[MovieDescModel] {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext

        let fetch = NSFetchRequest<NSManagedObject>(entityName: "MovieDesc")
        var arrayOfMoviesDesc : [MovieDescModel] = [] 
        do{
            let movieDesc = try context?.fetch(fetch)
            guard let moviesDesc = movieDesc else{return []}
            for item in moviesDesc  {
                let movieChara = item.value(forKey: "movieChara")
                let movieId = item.value(forKey: "movieId")
                let movieType = item.value(forKey: "movieType")

                let movieDescData = MovieDescModel(movieChara: movieChara as? String,
                                                    movieId: movieId as? Int,
                                                    movieType: movieType as? String)
                arrayOfMoviesDesc.append(movieDescData)
            }
        }catch let error{
            print(error.localizedDescription)
        }
//        print(arrayOfMoviesDesc)
        return arrayOfMoviesDesc
    }
    
}
