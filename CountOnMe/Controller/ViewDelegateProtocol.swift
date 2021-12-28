//
//  ViewDelegateProtocol.swift
//  CountOnMe
//
//  Created by Ernesto Elias Aquino Cifuentes on 28/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol ViewDelegate: AnyObject {
    func clear()
    func warningMessage(_ message: String)
    func addResultat(_ operationsToReduce: [String])
    func addMathematicalOperator(_ mathematicalOperator: String)
    
    var canAddOperator: Bool {get}
    var expressionIsCorrect: Bool {get}
    var expressionHaveEnoughElement: Bool {get}
    var expressionHaveResult: Bool {get}
    var elements: [String] {get}
}
