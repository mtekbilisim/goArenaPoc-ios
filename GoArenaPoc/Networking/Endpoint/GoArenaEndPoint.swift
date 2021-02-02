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
    case feeds

}

extension GoArenaApi: EndPointType {
 
    // MARK: - EndPointType

    var environmentBaseURL : String {
        switch NetworkManager.environment {
        
        case .dev: return "http://turkcell.mtek.me:8080/" //Working code copy. Changes made by developers are deployed here so integration and features can be tested. This environment is rapidly updated and contains the most recent version of the application.
        
        case .qa: return "http://turkcell.mtek.me:8080/" // (Not all companies will have this). Environment for quality assurance; this provides a less frequently changed version of the application which testers can perform checks against. This allows reporting on a common revision so developers know whether particular issues found by testers has already been corrected in the development code.
        //Quality Assurance
        //STB

        case .staging: return "http://turkcell.mtek.me:8080/" //This is the release candidate, and this environment is normally a mirror of the production environment. The staging area contains the "next" version of the application and is used for final stress testing and client/manager approvals before going live.
        //test
        //PRP

        case .production: return "http://turkcell.mtek.me:8080/" //This is the currently released version of the application, accessible to the client/end users. This version preferably does not change except for during scheduled releases.
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

        case .feeds:
            return "feeds"
        
            
         // end path
        }
            
    }
    
    // MARK: - HTTPMethod

    var httpMethod: HTTPMethod {
        switch self {
       
        // MARK: - AUTH
        case  .feeds:
            return .get
       
        
        // end httpMethod

        }
    }
    
    // MARK: - HTTPTask
    // MARK: - Params

    var task: HTTPTask {
        switch self {
        
        // MARK: - AUTH
        case .feeds:
            return .request

        
        // end task

        }
    }
    // MARK: - HTTPHeaders

    var headers: HTTPHeaders? {
        switch self {

        default:
            return nil
        // end headers

        }
    }
}



