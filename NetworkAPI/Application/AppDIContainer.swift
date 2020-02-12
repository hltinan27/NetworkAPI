//
//  AppDIContainer.swift
//  NetworkAPI
//
//  Created by Halit inan on 12.02.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation

public final class AppDIContainer {
    
    public static var shared = AppDIContainer()
    lazy var customService = CustomService()
    
    private init() { }
    
    public func makeCustomContainer() -> CustomContainer {
        let dependencies = CustomContainer.Dependencies(customService: customService)
        return CustomContainer(dependencies: dependencies)
    }
}
