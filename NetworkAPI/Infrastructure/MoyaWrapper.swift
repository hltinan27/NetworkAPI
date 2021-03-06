//
//  MoyaWrapper.swift
//  Movies
//
//  Created by Halit inan on 30.01.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation
import Moya

let API_BASE_URL = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/25/explicit.json"
let API_KEY = "2696829a81b1b5827d515ff121700838"

public class MoyaWrapper<T: TargetType> {
    
    var provider: MoyaProvider<T>
    
    public init() {
        self.provider = MoyaProvider<T>(endpointClosure: endpointClosure, requestClosure: requestClosure, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
    }
    
    func request<R: Codable>(_ target: T, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping (_ response: R?, _ error: Error?) -> Void) {
        self.provider.request(target, callbackQueue: callbackQueue, progress: progress) { result in
            switch result
            {
            case let .success(moyaResponse):
                do
                {
                    if let httpResponse = moyaResponse.response {
                        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 400)
                        {
                            let response = try moyaResponse.map(R.self)
                            completion(response, nil)
                        }
                        else if (httpResponse.statusCode == 422)
                        {
                            print(try moyaResponse.mapString())
                        }
                        else if (httpResponse.statusCode == 429)
                        {
                            let response = try moyaResponse.map(R.self)
                            completion(response, nil)
                        }
                        else if (httpResponse.statusCode == 500)
                        {
                            let error: Error = (try moyaResponse.map(ErrorWrapper.self) as ErrorWrapper).Error
                            completion(nil, error)
                        }
                        else if (httpResponse.statusCode == 401 || httpResponse.statusCode == 403)
                        {
                            let error: Error = (try moyaResponse.map(ErrorWrapper.self) as ErrorWrapper).Error
                            completion(nil, error)
                        } else if (httpResponse.statusCode == 404) {
                            let error = Error(errorCode: ErrorCode.ApiFailure, errorMessage: "İşleminizi şu anda gerçekleştiremiyoruz.")
                            completion(nil, error)
                        }
                    }
                }
                catch
                {
                    let error = Error(errorCode: ErrorCode.ApiFailure, errorMessage: "İşleminizi şu anda gerçekleştiremiyoruz.")
                    completion(nil, error)
                }
                break
            case let .failure(moyaError):
                print("MOYA EROR")
                print(moyaError)
                let error = Error(errorCode: ErrorCode.ApiFailure, errorMessage: "İşleminizi şu anda gerçekleştiremiyoruz. (M)")
                completion(nil, error)
                break
            }
        }
    }
    
    func requestString(_ target: T, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completion: @escaping (_ response: String?, _ error: Error?) -> Void) {
        self.provider.request(target, callbackQueue: callbackQueue, progress: progress) { result in
            switch result
            {
            case let .success(moyaResponse):
                do
                {
                    if let httpResponse = moyaResponse.response {
                        
                        if (httpResponse.statusCode == 200)
                        {
                            let response = try moyaResponse.mapString()
                            completion(response, nil)
                        }
                        else if (httpResponse.statusCode == 422)
                        {
                            print(try moyaResponse.mapString())
                        }
                        else if (httpResponse.statusCode == 500)
                        {
                            let error: Error = (try moyaResponse.map(ErrorWrapper.self) as ErrorWrapper).Error
                            completion(nil, error)
                        }
                        else if (httpResponse.statusCode == 401 || httpResponse.statusCode == 403)
                        {
                            let error: Error = (try moyaResponse.map(ErrorWrapper.self) as ErrorWrapper).Error
                            completion(nil, error)
                        } else if (httpResponse.statusCode == 404) {
                            let error = Error(errorCode: ErrorCode.ApiFailure, errorMessage: "İşleminizi şu anda gerçekleştiremiyoruz.")
                            completion(nil, error)
                        }
                    }
                }
                catch
                {
                    let error = Error(errorCode: ErrorCode.ApiFailure, errorMessage: "İşleminizi şu anda gerçekleştiremiyoruz.")
                    completion(nil, error)
                }
                break
            case let .failure(moyaError):
                print("MOYA EROR")
                print(moyaError)
                let error = Error(errorCode: ErrorCode.ApiFailure, errorMessage: "İşleminizi şu anda gerçekleştiremiyoruz.")
                completion(nil, error)
                break
            }
        }
    }
    
    let endpointClosure = { (target: T) -> Endpoint in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        
        let endpoint: Endpoint = Endpoint(url: url,
                                          sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                          method: target.method,
                                          task: target.task,
                                          httpHeaderFields: target.headers)
        return endpoint
    }
    
    let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
        do {
            var request = try endpoint.urlRequest()
            let json = String(data: request.httpBody ?? Data(), encoding: .utf8)!
            done(.success(request))
        } catch {
            done(.failure(MoyaError.underlying(error, nil)))
        }
    }
}

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}
