//
//  ParameterEncoding.swift
//  KidsVid Demo
//
//  Created by Adem Özsayın on 23.09.2020.
//

import Foundation

public typealias Parameters = KeyValuePairs<String,Any>
public typealias JsonParameters = [String:Any]

public protocol JsonParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: JsonParameters) throws
}
public protocol JsonArrayParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: [JsonParameters]) throws
}
public protocol UrlParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
//public protocol ArrayEncoding {
//    func encode(urlRequest: inout URLRequest, with array:[Any]) throws
//}

public enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding

    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: JsonParameters?,
                       urlParameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)

            }
        }catch {
            throw error
        }
    }
    
}
    
    public enum ArrayParameterEncoding {
        
        
        case jsonArrayEncoding
        case urlAndJsonAraryEncoding
        public func arrayEncode(urlRequest: inout URLRequest,
                               bodyParameters:[JsonParameters],
                               urlParameters: Parameters?) throws {
            do {
                switch self {
                case .jsonArrayEncoding:
                    
                    try JSONArrayParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                    
                case .urlAndJsonAraryEncoding:
                    guard let urlParameters = urlParameters else { return }
                    try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                    try JSONArrayParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                }
        }catch {
            throw error
        }
    }
    }

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

//
//public struct JSONDocumentArrayEncoding: ArrayEncoding {
//    public func encode(urlRequest: inout URLRequest, with array:[Any]) throws {
//        do {
////            let jsonAsData = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
//            let jsonAsData = try JSONSerialization.data(withJSONObject: array, options: [])
//
//            urlRequest.httpBody = jsonAsData
//            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
//                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            }
//        }catch {
//            throw NetworkError.encodingFailed
//        }
//    }
//}
//
//
//
