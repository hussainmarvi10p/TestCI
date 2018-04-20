//
//  NetworkService.swift
//  MVVM
//
//  Created by Muhammad Yawar on 12/13/17.
//  Copyright © 2017 Muhammad Yawar. All rights reserved.
//

import Foundation

struct NetworkService : NetworkAdaptor {
    
   static func request<T: Decodable >(_ url: String,
                 method: RequestHTTPMethod,
                 parameters: [String: Any]?,
                 headers: [String: String]?,
                 model : T.Type,
                 onComplete: @escaping ((NetworkDataResponse) -> Void)) {
        
    
    
        guard let url = URL(string : url) else  { return }
        var urlRequest: URLRequest = URLRequest(url: url , cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = method.rawValue
        
        if headers != nil {
            for (key,value) in headers! {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
    
    if let postParams = parameters {
        
        if let httpBody = postData(ForPostParams: postParams as Dictionary<String, AnyObject>, contentType: ContentType.urlEncoded) {
            urlRequest.httpBody = httpBody
        }
        
        urlRequest.setValue(ContentType.urlEncoded.getValue(), forHTTPHeaderField: "Content-Type")
    }
    
        URLSession.shared.dataTask(with: urlRequest) { (data : Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    let networkError = NetworkError(title: "Error", description: error!.localizedDescription, error : error)
                    return onComplete(NetworkDataResponse(responseModel: nil, result: .failure,error: networkError))
                }
                if let data = data {
                    
                    var decodedObject: Decodable?
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        print(json)
                        decodedObject = try JSONDecoder().decode(model, from: data)
                    }
                    catch let jsonErr {
                        print("error: \(jsonErr.localizedDescription)")
                        //                    let networkError = NetworkError(title: "Error", description:, error : error)
                        //                    return return onComplete(NetworkDataResponse(responseModel: nil, result: .failure,error: networkError))
                    }
                    let result: NetworkResult = error == nil ? .success : .failure
                    let networkResponse = NetworkDataResponse(responseModel : decodedObject,
                                                              result: result,
                                                              error: nil)
                    onComplete(networkResponse)
                }
            }
        }.resume()
    }
    
//    func createBodyWithParameters(parameters: [String: AnyObject]?) -> Data {
//        var body = Data();
//
//        if parameters != nil {
//            for (key, value) in parameters! {
//                body.appendString(string: "--\(Constants.boundaryString)\r\n")
//                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                body.appendString(string: "\(value)\r\n")
//            }
//        }
//
//        body.appendString(string: "\r\n")
//        body.appendString(string: "--\(Constants.boundaryString)--\r\n")
//
//        return body
//    }
    
    static func postData(ForPostParams params:Dictionary<String, AnyObject>, contentType:ContentType) -> Data? {
        
        var data:Data? = nil
        
        if contentType == .urlEncoded {
            
            var postString = ""
            
            for (key, value) in params {
                postString += "\(key)=\(value)&"
            }
            
            data = String(postString.characters.dropLast()).data(using: .utf8)
        }
            
        else if contentType == .json
        {
            do {
                data = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            } catch {
                data = nil
            }
        }
            
        else if contentType == .formData
        {
            //data = createBodyWithParameters(parameters: params)
        }
        
        return data
    }
}
