//
//  Like.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation
//
//id*    integer($int64)
//postDate    string($date-time)
//feedId*    integer($int64)
//user*

struct Like:Codable {
    var id:Int
    var postDate:String
    var feedId:Int
    var user:User
}
