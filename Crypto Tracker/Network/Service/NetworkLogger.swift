//
//  NetworkLogger.swift
//  Crypto Tracker
//
//  Created by Nihad Allahveranov on 06.07.23.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    static func log(response: URLResponse) {
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid URLResponse")
            return
        }
        
        print("Response URL: \(httpResponse.url?.absoluteString ?? "")")
        print("Response Status Code: \(httpResponse.statusCode)")
        
        let headers = httpResponse.allHeaderFields
        print("Response Headers:")
        for (key, value) in headers {
            print("\(key): \(value)")
        }
        
        print("-------------")
    }
}
