//
//  ViewDelegateProtocol.swift
//  CountOnMe
//
//  Created by Ernesto Elias Aquino Cifuentes on 28/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol ViewDelegate: AnyObject {
    func warningMessage(_ message: String)
    func addResultat(_ resultat: String)
    func addMathematicalOperator(_ mathematicalOperator: String)
    func addCharacterToTextView (_ char: String)
}
