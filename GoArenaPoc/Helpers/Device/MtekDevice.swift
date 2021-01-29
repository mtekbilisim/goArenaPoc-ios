//
//  MtekDevice.swift
//  Kids Provider
//
//  Created by Adem Özsayın on 7.11.2020.
//

import Foundation


extension Device {
    
    public static func isIPhoneXSimilar() -> Bool {
        switch Device.size() {
        case .screen5_8Inch, .screen6_1Inch, .screen6_5Inch, .screen5_4Inch:
            return true
        default:
            return false
        }
    }
    
    public static func isIPadScreen() -> Bool {
        switch Device.size() {
        case .screen7_9Inch,
             .screen9_7Inch,
             .screen10_2Inch,
             .screen10_5Inch,
             .screen10_9Inch,
             .screen11Inch,
             .screen12_9Inch:
            return true
        default:
            return Device.isPad()
        }
    }
}
