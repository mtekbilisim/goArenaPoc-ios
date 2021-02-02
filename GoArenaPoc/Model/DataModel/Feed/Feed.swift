//
//  Feed.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import Foundation

struct Feed:Codable {
    var id:Int?
    var title:String
    var postType:PostType?
    var likes:Int?
    var comments:[Comment]?
    var postDate: String?
    var medias:[Media]?
    var user:User
    var status:FeedStatus
}




