//
//  AuthResponse.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 3.02.2021.
//

import Foundation

struct AuthResponse:Codable {
    var token_type:String?
    var expires_in:Int?
    var access_token:String?
    var scope:String?
    var error:String?   
}
