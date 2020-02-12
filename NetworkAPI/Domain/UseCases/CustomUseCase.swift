//
//  CustomUseCase.swift
//  NetworkAPI
//
//  Created by Halit inan on 11.02.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation

public protocol CustomUseCase {
    func execute(requestValue: CustomRequest,
                 completion: @escaping (String?, Error?) -> Void)
}

 final class DefaultCustomUseCase: CustomUseCase {

    private let customRepository: CustomRepository
    
    init(customRepository: CustomRepository) {
        self.customRepository = customRepository
    }
    
    func execute(requestValue: CustomRequest,
                 completion: @escaping (String?, Error?) -> Void) {

        customRepository.doCustomRequest(request: requestValue) { (response, error) in
            if error == nil {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
