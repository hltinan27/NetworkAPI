//
//  Error.swift
//  Movies
//
//  Created by Halit inan on 30.01.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation

enum ErrorCode
{
    static let ApiCall = "10000"
    static let ApiFailure = "10001"
}

public struct Error: Codable
{
    public var ErrorCode: Int!
    public var ErrorMessage: String!
    public var Action: Int!
    
    public init(errorCode: String, errorMessage: String)
    {
        self.ErrorCode = 0
        self.ErrorMessage = errorMessage
        self.Action = nil
    }
}

struct ErrorWrapper: Codable
{
    var Error: Error!
}
