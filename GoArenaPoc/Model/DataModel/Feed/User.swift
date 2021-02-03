//
//  User.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import Foundation

struct User: Codable {
    
    var id: Int?
    var username: String?
    var avatar:String?
    
    var first_name:String?
    var last_name:String?
    var password:String?
    var employee_type:EmployeeType?
    var shopId:Int?
    
//    private enum UserCodingKeys : String, CodingKey {
//        case id = "id"
//        case username = "username"
//        case avatar = "avatar"
//
//        case first_name = "first_name"
//        case last_name = "last_name"
//        case password = "password"
//        case employee_type = "employee_type"
//        case shopId = "shopId"
//
//    }
    
    init(id:Int) {
        self.id = id
    }
        
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: UserCodingKeys.self)
//        id = try container.decode(Int.self, forKey: .id)
//        username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
//        avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
//
////        first_name = try container.decodeIfPresent(String.self, forKey: .first_name) ?? ""
////        last_name = try container.decodeIfPresent(String.self, forKey: .last_name) ?? ""
////        password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
////        employee_type = try container.decode(EmployeeType.self, forKey: .employee_type)
////        shopId = try container.decode(Int.self, forKey: .shopId)
//
//
//    }

//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: UserCodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(username, forKey: .username)
//        try container.encode(avatar, forKey: .avatar)
//        
////        try container.encode(first_name, forKey: .first_name)
////        try container.encode(last_name, forKey: .last_name)
////        try container.encode(password, forKey: .password)
////        try container.encode(employee_type, forKey: .employee_type)
////        try container.encode(shopId, forKey: .shopId)
//
//    }
}

extension User {
   
    private static let currentUserKey = "CurrentUser"
    private static let tokenKey = "tokenKey"
    private static let rememberMe = "rememberMe"
    
    static func currentUser() -> User? {

        guard let userData = UserDefaults.standard.data(forKey: currentUserKey) else { return nil }
        return User.from(data: userData)

    }
 
    static func loggedIn() -> Bool {
        return currentUser() != nil
    }
    
    static func getUserId() -> Int? {
        guard let userData = UserDefaults.standard.data(forKey: currentUserKey) else { return nil }
        let user =  User.from(data: userData)
        guard let userId = user?.id else { return nil}
        return userId
    }

    static func saveUser(user: User) {

        let userDefaults = UserDefaults.standard
        do {
           try userDefaults.setObject(user, forKey: currentUserKey)
        } catch {
           print((error as! ObjectSavableError).localizedDescription)
        }
    }
    
    static func getPassword() -> String {
        return  UserDefaults.standard.string(forKey: "password") ?? ""
    }
     
    static func setPassword(password: String) {
         
        UserDefaults.standard.set(password, forKey: "password")
        print(" setted password: \(self.getPassword())")
     }
    
    static func saveToken(token:String){
        UserDefaults.standard.set(token, forKey: tokenKey)
        print("storedToken: \(self.storedToken())")
    }

    static func storedToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: tokenKey) else {
            return ""
        }
        return "Bearer \(token)"
    }
  
    static func logout() {
        UserDefaults.standard.removeObject(forKey: currentUserKey)
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.synchronize()
    }
}

extension User : Equatable {

public static func ==(lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
  }
}



struct GoArenaUser {
    
    private static let rememberMe = "RememberMe"

    func getRememberMe() -> Bool?  {
        return UserDefaults.standard.bool(forKey:GoArenaUser.rememberMe)
     }
     
     func setRememberMe(bool: Bool) {
       UserDefaults.standard.set(bool, forKey: GoArenaUser.rememberMe)
     }
    
    func getEmailForLoginInfo() -> String? {
         return  UserDefaults.standard.string(forKey: "email")
     }
     
     func setEmailForLoginInfo(email: String) {
         UserDefaults.standard.set(email, forKey: "email")
     }
     
    
}


extension Decodable {
    
    static func from(json: String, using encoding: String.Encoding = .utf8) -> Self? {
        guard let data = json.data(using: encoding) else { return nil }
        return from(data: data)
    }
    
    static func from(data: Data) -> Self? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
}







