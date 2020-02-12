//
//  CustomContainer.swift
//  NetworkAPI
//
//  Created by Halit inan on 11.02.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation

public final class CustomContainer {
    
    public init() {}
    
    public func makeCustomUseCase() -> CustomUseCase {
        return DefaultCustomUseCase(customRepository: makeCustomRepository())
    }
    
    // MARK: - Repositories
    public func makeCustomRepository() -> CustomRepository {
        return DefaultCustomRepository(service: CustomService())
    }
}
