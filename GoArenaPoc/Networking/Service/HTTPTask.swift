//
//  HTTPTask.swift
//  KidsVid Demo
//
//  Created by Adem Özsayın on 23.09.2020.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: JsonParameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    case requestArrayParameters(bodyParameters: [JsonParameters],
        bodyEncoding: ArrayParameterEncoding,
        urlParameters: Parameters?)
    case requestArrayParametersAndHeaders(bodyParameters: [JsonParameters],
        bodyEncoding: ArrayParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
    case requestParametersAndHeaders(bodyParameters: JsonParameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
}

