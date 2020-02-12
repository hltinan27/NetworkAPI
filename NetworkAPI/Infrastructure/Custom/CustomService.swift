//
//  CustomService.swift
//  NetworkAPI
//
//  Created by Halit inan on 11.02.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation

public class CustomService: MoyaWrapper<CustomApi> {
    
    public func getCustomResponse(_ request: CustomRequest, completion: @escaping (String?, Error?) -> Void) {
        self.requestString(.customRequest(request), completion: completion)
    }
}
