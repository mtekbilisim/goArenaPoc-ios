//
//  GoArenaEndPoint.swift
//  GoArenaEndPoc
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

    // MARK: - FEED
    case feeds
    case addPost(model: AddPostRequest)
    case postMediaForFeed(feedId: Int, file:File)
    case deleteFeed(feedId:Int)
    case updateFeed(feedId:Int, model: AddPostRequest)
   
    // MARK: - DASHBOARD

    case sales
    case employeeSalesWithShopId
    case getExpectationWithEmployeeAndShopId
    case dashboardChartUser(userId:Int)
    
    case getToken(email:String, password:String)
    case me

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
       
        // MARK: - FEED

        case .feeds, .addPost:
            return "feeds"
       
        case .postMediaForFeed(let feedId, _ ):
            return "feeds/\(feedId)/medias"
        
        case .deleteFeed(let feedId):
            return "feeds/\(feedId)"
       
        case .updateFeed(let feedId, _):
            return "feeds/\(feedId)"
            
        // MARK: - DASHBOARD
        
        case .sales:
            return "dashboard"
        case .employeeSalesWithShopId:
            return "dashboard"
            
        case .getExpectationWithEmployeeAndShopId:
            return "dashboard/expectations"
         // end path
        
        // MARK: - AUTH
        
        case .getToken:
            return "authentication/token"
       
        case .me:
            return "authentication/me"
            
        case .dashboardChartUser(let userId):
            return "dashboard/charts/shop/\(userId)/employees"
        }
            
    }
    
    // MARK: - HTTPMethod

    var httpMethod: HTTPMethod {
        switch self {
       
        // MARK: - FEED
        case  .feeds:
            return .get
        case .addPost:
            return .post
        case .postMediaForFeed:
            return .post
            
        case .updateFeed:
            return .put
            
        case .deleteFeed:
            return .delete
            
        // MARK: - DASHBOARD
        case .sales:
            return .get
            
        case .employeeSalesWithShopId:
            return .get
            
        case .getExpectationWithEmployeeAndShopId:
            return .get
            
        case .getToken:
            return .post
            
        case .me:
            return .get

        case .dashboardChartUser:
            return .get
        
        // end httpMethod

        }
    }
    
    // MARK: - HTTPTask
    // MARK: - Params

    var task: HTTPTask {
        switch self {
        
        // MARK: - FEED
        case .feeds:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)

            
        case .addPost(let model):
            return .requestParametersAndHeaders(bodyParameters: ["title": model.title as Any,
                                                       "postType": model.postType!.rawValue,
//                                                       "likes": 0,
                                                       "postDate": "2021-02-02T14:14:45.283Z",
                                                       "userId": 8,
                                                       "status": model.status.rawValue],
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil,additionHeaders: headers)
            
        case .postMediaForFeed(let feedId, let file):
            return .requestParametersAndHeaders(bodyParameters: ["uri": file.fileDownloadUri,
                                                       "mimeType": file.fileType,
                                                       "feedId": feedId,
                                                       "userId": 8],
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil,additionHeaders: headers)
            
        case .updateFeed(let feedId, let model):
            return .requestParametersAndHeaders(bodyParameters: ["id":feedId,
                                                       "userId":8,
                                                       "title": model.title as Any,
                                                       "postType": model.postType!.rawValue,
//                                                       "likes": 0,
                                                       "postDate": "2021-02-02T14:14:45.283Z",
                                                       "status": "APPROVED"], // change thıs to Draft
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil,additionHeaders: headers)
            
        case .deleteFeed:
            return .request
            
        // MARK: - DASHBOARD
        
        case .sales:
            return .request
        case .employeeSalesWithShopId:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["employee":8,"shop":3], additionHeaders: headers)
            
        case .getToken(let email, let password):
            return .requestParametersAndHeaders(bodyParameters: ["email":email,
                                                       "password":password], bodyEncoding: .jsonEncoding,
                                      urlParameters: nil, additionHeaders: headers)
            
        case .me:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
            
            
        case .getExpectationWithEmployeeAndShopId:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["employee":8,"shop":3], additionHeaders:headers)
            
        case .dashboardChartUser:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
        // end task
        }
    }
    // MARK: - HTTPHeaders

    var headers: HTTPHeaders? {
        switch self {
        case .me,.feeds,. addPost , .postMediaForFeed, .updateFeed, .deleteFeed, .sales, .employeeSalesWithShopId, .getExpectationWithEmployeeAndShopId ,.dashboardChartUser:
            return ["Authorization": User.storedToken()]
        default:
            return nil
        // end headers

        }
    }
}



