//
//  ViewDelegateProtocol.swift
//  CountOnMe
//
//  Created by Ernesto Elias Aquino Cifuentes on 28/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

protocol ViewDelegate: AnyObject {
    func warningMessage(_ message: String)
    func refreshTextViewWithValue(_ value: String)
    
}
