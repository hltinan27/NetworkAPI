//
//  CustomAPI.swift
//  NetworkAPI
//
//  Created by Halit inan on 11.02.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation
import Moya

public enum CustomApi {
    case customRequest(CustomRequest)
}

extension CustomApi: TargetType {
    public var baseURL: URL {
        switch self {
        case .customRequest(let request):
            return URL(string: request.baseURL ?? "")!
        }
    }
    
    public var path: String {
        switch self {
        case .customRequest(let request):
            return request.path ?? ""
        }
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
