//
//  Sale.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation

struct Sale:Codable {
    var id:Int?
    var product:String?
    var product_group:String?
    var quantity:Int?
    var date_time:String?
    var amount:Int?
    var shop:Shop?
    var user:Employee?
    
}
