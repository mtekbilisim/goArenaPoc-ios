//
//  User.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 30.01.2021.
//

import Foundation

struct User: Codable {
    
    var id: String?
    var firstname: String?
    var lastname: String?
    var email:String?
    var avatar:String?
    var birthday:String?
    var phoneNumber:String?
    var password:String?
    var deviceToken:String?
    
    private enum UserCodingKeys : String, CodingKey {
        
        case id = "id"
        case firstname = "first_name"
        case lastname = "last_name"
        case email = "email"
        case avatar = "avatar"
        case title = "title"
        case birthday = "birthday"
        case phoneNumber = "phone_number"
        case password = "password"
        case deviceToken = "device_token"
        
    }
    
    init(id:String) {
        self.id = id
    }
        
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        firstname = try container.decodeIfPresent(String.self, forKey: .firstname) ?? ""
        lastname = try container.decodeIfPresent(String.self, forKey: .lastname) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        birthday = try container.decodeIfPresent(String.self, forKey: .birthday) ?? ""
        phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
        password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        deviceToken = try container.decodeIfPresent(String.self, forKey: .deviceToken) ?? ""

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstname, forKey: .firstname)
        try container.encode(lastname, forKey: .lastname)
        try container.encode(email, forKey: .email)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(birthday, forKey: .birthday)
        try container.encode(password, forKey: .password)
        try container.encode(deviceToken, forKey: .deviceToken)
        try container.encode(phoneNumber, forKey: .phoneNumber)


    }
    
   
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
        guard let userId = Int((user?.id)!) else { return nil}
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
    return lhs.id == rhs.id &&
        lhs.email == rhs.email
        
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







