//
//  FlixAPIManager.swift
//  Flix
//
//  Created by Ryan Sullivan on 1/14/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

class FlixAPIManager: NSObject {
    static let instance = FlixAPIManager()
    
    private override init() {
        
    }
    
    static func sharedInstance() -> FlixAPIManager {
        return instance
    }
    
    func getPageCount(callback: @escaping (_ count: Int) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, _, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try? JSONSerialization.jsonObject(with: data, options: []),
                let map = dataDictionary as? [String: Any],
                let total = map["total_results"] as? Int {
                    callback(total)
                }
        }
        task.resume()
    }
    
    func getMovies(page: Int, callback: @escaping (_ movies: [Movie]) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&page=\(page)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, _, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try? JSONSerialization.jsonObject(with: data, options: []),
                let map = dataDictionary as? [String: Any] {
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                print(map["total_results"])
                if let movieMaps = map["results"] as? [Any] {
                    var movies: [Movie] = []
                    for movieMap in movieMaps {
                        if let movieMap = movieMap as? [String: Any] {
                            if let id = movieMap["id"] as? Int,
                                let title = movieMap["title"] as? String,
                                let posterPath = movieMap["poster_path"] as? String,
                                let overview = movieMap["overview"] as? String {
                                let movie = Movie(id: id, title: title, posterPath: posterPath, overview: overview)
                                movies.append(movie)
                            }
                        }
                    }
                    callback(movies)
                }
                //print(map["results"])
                
            }
        }
        task.resume()
    }
    
    func getSimilar(callback: @escaping (_ movies: [Movie]) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, _, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try? JSONSerialization.jsonObject(with: data, options: []),
                let map = dataDictionary as? [String: Any] {
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                print(map["total_results"])
                if let movieMaps = map["results"] as? [Any] {
                    var movies: [Movie] = []
                    for movieMap in movieMaps {
                        if let movieMap = movieMap as? [String: Any] {
                            if let id = movieMap["id"] as? Int,
                                let title = movieMap["title"] as? String,
                                let posterPath = movieMap["poster_path"] as? String,
                                let overview = movieMap["overview"] as? String {
                                let movie = Movie(id: id, title: title, posterPath: posterPath, overview: overview)
                                movies.append(movie)
                            }
                        }
                    }
                    callback(movies)
                }
                //print(map["results"])
                
            }
        }
        task.resume()
    }
}
