//
//  GenericResponse.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 27.01.2021.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    
    // MARK: - Properties
 
    let publicStatus: Bool?
    let data: T?
    
    private enum GenericCodingKeys: String, CodingKey {
        case publicStatus  = "public"
        case data = "data"
    }

    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: GenericCodingKeys.self)
        
        publicStatus = (try? keyedContainer.decode(Bool.self, forKey: GenericCodingKeys.publicStatus)) ?? false
        data = try keyedContainer.decode(T.self, forKey: GenericCodingKeys.data)
    }
}


struct KidsDefaultResponse {
    let message: String?
    let data: String?
}

extension KidsDefaultResponse: Codable {
    private enum KidsDefaultResponseCodingKeys: String, CodingKey {
        case message = "Message"
        case data = "Data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KidsDefaultResponseCodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        data = try container.decodeIfPresent(String.self, forKey: .data) ?? ""
    }
}

struct KidsGenericError {
    let error:KidsError
}

extension KidsGenericError:Codable {
    private enum GenericErrorCodingKeys: String, CodingKey {
        case error = "error"
    }
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: GenericErrorCodingKeys.self)
        error = try keyedContainer.decode(KidsError.self, forKey: GenericErrorCodingKeys.error)

    }
}

struct KidsError:Codable {
    let code:Int?
    let message:String?
    
    private enum GenericErrorCodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
    }
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: GenericErrorCodingKeys.self)
        code = (try? keyedContainer.decode(Int.self, forKey: GenericErrorCodingKeys.code))
        message = (try? keyedContainer.decode(String.self, forKey: GenericErrorCodingKeys.message))
    }
    
    init(code: Int?, message: String?) {
        self.code = code
        self.message = message
    }
}
