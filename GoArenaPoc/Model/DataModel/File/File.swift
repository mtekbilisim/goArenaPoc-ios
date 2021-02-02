//
//  File.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation
struct FileResponse:Codable {
    var data:File
}

public struct File:Codable {
    var fileName :String
    var fileDownloadUri:String
    var fileType:String
    var size:Int
}
