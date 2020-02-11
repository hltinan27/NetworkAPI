//
//  MoviesService.swift
//  Movies
//
//  Created by Halit inan on 31.01.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation

public class MoviesService: MoyaWrapper<MoviesApi> {
    
    public func getMovieList(_ request: String, completion: @escaping (TopMoviesResponse?, Error?) -> Void) {
        self.request(.moviesList, completion: completion)
    }
}
