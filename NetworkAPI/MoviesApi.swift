//
//  MoviesApi.swift
//  Movies
//
//  Created by Halit inan on 31.01.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation
import Moya

public enum MoviesApi {
    case moviesList
}

extension MoviesApi: TargetType {
    public var baseURL: URL {
        return URL(string: API_BASE_URL)!
    }
    
    public var path: String {
        return ""
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
