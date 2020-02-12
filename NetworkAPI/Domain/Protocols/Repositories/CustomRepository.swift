//
//  CustomRepository.swift
//  NetworkAPI
//
//  Created by Halit inan on 11.02.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation

public protocol CustomRepository {
    func doCustomRequest(request: CustomRequest, comletion: @escaping (String?, Error?) -> Void)
}
