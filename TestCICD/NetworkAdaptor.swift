//
//  NetworkAdaptor.swift
//  MVVM
//
//  Created by Muhammad Yawar on 12/13/17.
//  Copyright © 2017 Muhammad Yawar. All rights reserved.
//

import Foundation

enum RequestHTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

protocol NetworkAdaptor {
    
   static func request<T: Decodable>(_ url: String,
                 method: RequestHTTPMethod,
                 parameters: [String: Any]?,
                 headers: [String: String]?,
                 model : T.Type,
                 onComplete: @escaping ((NetworkDataResponse) -> Void))
}

extension NetworkAdaptor {
    
  static func request<T: Decodable>(_ url: String,
                 method: RequestHTTPMethod = .get,
                 parameters: [String : Any]? = nil,
                 headers: [String: String]? = nil,
                 model : T.Type,
                 onComplete: @escaping ((NetworkDataResponse) -> Void)) {
        
        request(url, method: method,
                parameters: parameters,
                headers: headers,
                model : model,
                onComplete: onComplete)
    }
}
