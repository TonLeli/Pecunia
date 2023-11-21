//
//  Double+Extension.swift
//  pecunia
//
//  Created by Wellington on 18/11/23.
//

import Foundation

extension Double {
    func toCurrencyString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        if let formattedString = formatter.string(from: self as NSNumber) {
            return formattedString
        } else {
            return "\(self)"
        }
    }
}
