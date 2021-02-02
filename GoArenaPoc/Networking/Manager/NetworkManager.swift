//
//  NetworkManager.swift
//  KidsVid Demo
//
//  Created by Adem Özsayın on 23.09.2020.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case directusAuthenticationError = "Unauth user."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."

}

enum Result<T>{
    case success
    case failure(T)
}

struct NetworkManager {
    
    static let environment : GoArenaNetworkEnvironment = .staging
    let mainRouter = Router<GoArenaApi>()
    
    func sendRequest<T>(route: GoArenaApi, _ type: T.Type?, _ completion: @escaping ((ResponseModel<T>?, String?) -> Void)) {
        print(route)
        mainRouter.request(route) { (data, response, error) in
             if error != nil {
                completion(nil, error.debugDescription)
           }
           
           if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                     guard let responseData = data else {
                        completion(nil, "err")
                         return
                     }
                     do {
                         print(responseData)
                         let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                         print(jsonData)
                         let apiResponse = try JSONDecoder().decode(ResponseModel<T>.self, from: responseData)
                         completion(apiResponse,nil)
                        
                    } catch {
                     print(error)
           
                        completion(nil, error.localizedDescription)
                    }
                 
                case .failure(let networkFailureError):
                    print(networkFailureError)
                    printIfDebug(route.path)
                    printIfDebug(route.httpMethod.rawValue)
                    completion(nil,networkFailureError)
                }
           }
        }
    }
    
    func printIfDebug(_ string: String) {
        #if DEBUG
        print(string)
        #endif
    }
   
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299:
            return .success
        case 401:
            return .failure(NetworkResponse.directusAuthenticationError.rawValue)
        case 402...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
