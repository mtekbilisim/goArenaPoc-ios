//
//  Extensions+DateFormatter.swift
//  Kids Vid
//
//  Created by Adem Özsayın on 24.12.2020.
//

import UIKit

extension DateFormatter {
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}
