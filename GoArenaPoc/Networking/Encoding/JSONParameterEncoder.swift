//
//  JSONParameterEncoder.swift
//  KidsVid Demo
//
//  Created by Adem Özsayın on 23.09.2020.
//

import Foundation

public struct JSONParameterEncoder: JsonParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: JsonParameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}

public struct JSONArrayParameterEncoder: JsonArrayParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: [JsonParameters]) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
