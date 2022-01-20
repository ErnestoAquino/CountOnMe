//
//  UIButtonExtension.swift
//  CountOnMe
//
//  Created by Ernesto Elias on 24/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import UIKit

// This method applies a slight rounding to the buttons.

extension UIButton {
    func round(){
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
