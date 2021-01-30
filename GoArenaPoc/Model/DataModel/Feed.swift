//
//  Feed.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 29.01.2021.
//

import Foundation

struct Feed:Codable {
    var id:Int?
    var picture:String?
    var name:String?
    var postType:PostType?
    var detailText:String?
    var likes:String?
    var comments:String?
    var date: String?
    var images:[String]?
    
}

enum PostType: String{
    case text = "text", video = "video", images = "images", unknown
}

extension PostType: Codable {
    public init(from decoder: Decoder) throws {
        self = try PostType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
