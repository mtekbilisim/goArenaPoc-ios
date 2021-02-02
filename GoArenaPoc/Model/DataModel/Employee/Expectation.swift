//
//  Expectation.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation

struct Expectation:Codable {
    var id:Int
    var product:String
    var product_group:String
    var quantity:Int?
    var shop:Shop?
    var user:Employee
}
