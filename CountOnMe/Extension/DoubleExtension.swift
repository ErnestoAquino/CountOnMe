//
//  DoubleExtension.swift
//  CountOnMe
//
//  Created by Ernesto Elias on 15/01/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

// This method rounds a double to a decimal point.

extension Double {
    func roundedOneDecimal() -> Double {
        return ((self * 10).rounded() / 10)
    }
}
