//
//  Employee.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation

struct Employee:Codable {
    var id:Int?
    var last_name:String?
    var first_name: String?
    var email:String?
    var avatar:String?
    var password:String?
    var username:String?
    var employee_type:EmployeeType?
    
}

