//
//  Media.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation

struct Media:Codable {
    var id:Int
    var uri:String
    var mimeType: String
    var feedId:Int
    var userId:Int
}

