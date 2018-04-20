//
//  NetworkDataResponse.swift
//  MVVM
//
//  Created by Muhammad Yawar on 12/13/17.
//  Copyright © 2017 Muhammad Yawar. All rights reserved.
//

import Foundation

enum NetworkStatusCode: Int {
    case unauthorized = 401,
    forbidden = 403
}


struct NetworkError {
    
    let title: String
    let description: String
    let error: Error?
}

enum NetworkResult {
    case success,
    failure
}

struct NetworkDataResponse {
    
    let responseModel: Decodable?
    let result: NetworkResult
    var error: NetworkError?
}


struct ErrorModel : Error {
    var message:String
}

enum RequestError: Error {
    case invalidRequest,
    JSONConversionFailure
}
