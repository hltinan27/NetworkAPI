//
//  DefaultCustomRepository.swift
//  NetworkAPI
//
//  Created by Halit inan on 11.02.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation

final class DefaultCustomRepository {
    
     private let service: CustomService
    
    init(service: CustomService) {
        self.service = service
    }
}

extension DefaultCustomRepository: CustomRepository {
    func doCustomRequest(request: CustomRequest, comletion: @escaping (String?, Error?) -> Void) {
        service.getCustomResponse(request) { (response, error) in
            if error == nil {
                comletion(response!, nil)
            } else {
                comletion(nil ,error)
            }
        }
    }
}
