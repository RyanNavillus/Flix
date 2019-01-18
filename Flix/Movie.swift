//
//  Movie.swift
//  Flix
//
//  Created by Ryan Sullivan on 1/14/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

class Movie: NSObject {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    
    let releaseDate: Date? = nil
    let genreIds: [String] = []
    
    init(id: Int, title: String, posterPath: String, overview: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        super.init()
    }
    
}
