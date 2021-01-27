//
//  KidsEndPoint.swift
//  KidsVid Demo
//
//  Created by Adem Özsayın on 23.09.2020.
//

import Foundation

// MARK: - KidsVidNetworkEnvironment

enum GoArenaNetworkEnvironment {
    case dev
    case qa
    case staging
    case production
}

// MARK: - KidsVidApi

public enum GoArenaApi {

    // MARK: - AUTH
    case logout

}

extension GoArenaApi: EndPointType {
 
    // MARK: - EndPointType

    var environmentBaseURL : String {
        switch NetworkManager.environment {
        
        case .dev: return "" //Working code copy. Changes made by developers are deployed here so integration and features can be tested. This environment is rapidly updated and contains the most recent version of the application.
        
        case .qa: return "" // (Not all companies will have this). Environment for quality assurance; this provides a less frequently changed version of the application which testers can perform checks against. This allows reporting on a common revision so developers know whether particular issues found by testers has already been corrected in the development code.
        //Quality Assurance
        //STB

        case .staging: return "" //This is the release candidate, and this environment is normally a mirror of the production environment. The staging area contains the "next" version of the application and is used for final stress testing and client/manager approvals before going live.
        //test
        //PRP

        case .production: return "" //This is the currently released version of the application, accessible to the client/end users. This version preferably does not change except for during scheduled releases.
        //production
        
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    
    // MARK: - PATH

    var path: String {
        switch self {
       
        // MARK: - AUTH

        case .logout:
            return "auth/logout"
        
            
         // end path
        }
            
    }
    
    // MARK: - HTTPMethod

    var httpMethod: HTTPMethod {
        switch self {
       
        // MARK: - AUTH
        case  .logout:
            return .post
       
        
        // end httpMethod

        }
    }
    
    // MARK: - HTTPTask
    // MARK: - Params

    var task: HTTPTask {
        switch self {
        
        // MARK: - AUTH
        case .logout:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)

        
        // end task

        }
    }
    // MARK: - HTTPHeaders

    var headers: HTTPHeaders? {
        switch self {
        
        case .logout:
            return nil

        default:
            return nil
        // end headers

        }
    }
}



