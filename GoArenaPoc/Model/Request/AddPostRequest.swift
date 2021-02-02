//
//  AddPostRequest.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation


public struct AddPostRequest:Codable {
    var title:String?
    var postType:PostType?
    var likes:Int?
    var postDate:String?
    var userId:Int?
    var status:FeedStatus

    init(status:FeedStatus) {
        self.status = .DRAFT
    }
}
