//
//  KeyConstants.swift
//  TableGenie
//
//  Created by M Yawar on 10/21/17.
//  Copyright © 2017 M Yawar. All rights reserved.
//

import Foundation

struct Domain {
    static let BaseURL = "http://www.quadruplesolutions.com/projects/tableginne/api/"
}

struct Keys {
    
    struct Google{
        static let placesApiKey = "AIzaSyB-fVhWxKkpqN0d0IUpg-S16FwBEgvfUIA"
    }
}

enum ContentType : String {
    
    case urlEncoded
    case formData
    case json
    
    func getValue() -> String {
        switch self {
            
        case .urlEncoded:
            return "application/x-www-form-urlencoded"
            
        case .json:
            return "application/json"
            
        case .formData:
            return "multipart/form-data"
            
        }
    }
}

