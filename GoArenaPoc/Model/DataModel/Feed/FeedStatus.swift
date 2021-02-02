//
//  FeedStatus.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation

enum FeedStatus: String {
    case DRAFT, WAITING_APPROVAL, APPROVED, DECLINED, UNKNOWN
}

extension FeedStatus: Codable {
    public init(from decoder: Decoder) throws {
        self = try FeedStatus(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .UNKNOWN
    }
}
