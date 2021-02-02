//
//  Comment.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation

struct Comment:Codable {
    var id:Int
    var comment:String
    var postDate:String
    var user:User
    var feedId:Int
}

