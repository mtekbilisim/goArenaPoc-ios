//
//  EmployeeType.swift
//  GoArenaPoc
//
//  Created by Adem Özsayın on 2.02.2021.
//

import Foundation

enum EmployeeType: String {
    case  MANAGER, EMPLOYEE,UNKNOWN
}

extension EmployeeType: Codable {
    public init(from decoder: Decoder) throws {
        self = try EmployeeType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .UNKNOWN
    }
}

