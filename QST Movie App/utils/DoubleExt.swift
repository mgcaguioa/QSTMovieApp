//
//  DoubleExt.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/16/23.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func showDecimals(decimalCount: Int) -> String {
        return String(format: "%.\(decimalCount)f", self.round(to: 2))
    }
}
