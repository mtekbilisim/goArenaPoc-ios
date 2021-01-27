//
//  EndPointType.swift
//  KidsVid Demo
//
//  Created by Adem Özsayın on 23.09.2020.
//

import Foundation


protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

