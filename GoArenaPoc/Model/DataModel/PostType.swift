//
//  PostType.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation

enum PostType: String {
    case VIDEO, IMAGE, TEXT, UNKNOWN
}

extension PostType: Codable {
    public init(from decoder: Decoder) throws {
        self = try PostType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .UNKNOWN
    }
}
