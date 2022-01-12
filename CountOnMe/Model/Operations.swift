//
//  Operations.swift
//  CountOnMe
//
//  Created by Ernesto Elias on 22/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit


class Operations {
    
    // MARK: - Variables
    weak var viewDelegate: ViewDelegate?
    
    private (set) var stringWithData: String = ""
    
    private var elements: [String] {
        return stringWithData.split(separator: " ").map { "\($0)" }
    }
    
    private var testHaveResulta: Bool {
        return stringWithData.firstIndex(of: "=") != nil
    }

    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "×" && elements.last != "÷"
    }
    
    internal var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "×" && elements.last != "÷"
    }
    // MARK: - Constants
    private let message = "Un operateur est déjà mis !"
  
    enum OperatorType: String {
        case addition = " + "
        case subtraction = " - "
        case multiplication = " × "
        case division = " ÷ "
    }
    
    
    
    //MARK: - Functions
    
    func addOperator(type: OperatorType) {
        guard let delegate = viewDelegate else { return }
        if canAddOperator{
            stringWithData.append(type.rawValue)
            delegate.refreshTextViewWithValue(type.rawValue)
        } else {
            delegate.warningMessage(message)
        }
    }
    
//    func addOperator(type: OperatorType) {
//        if canAddOperator{
//            stringWithData.append(type.rawValue)
//            viewDelegate?.refreshTextViewWithValue(type.rawValue)
//        } else {
//            viewDelegate?.warningMessage(message)
//        }
//    }
    
    func resetStringWithData () {
        stringWithData = ""
    }
    
//    func doMathOperation() {
//        guard let delegate = viewDelegate else {return}
//
//        if !expressionIsCorrect || !expressionHaveEnoughElement {
//            return
//        }
//
//        var operationsToReduce = elements
//
//        // Iterate over operations while an operand still here
//        while operationsToReduce.count > 1 {
//            let left = Int(operationsToReduce[0])!
//            let operand = operationsToReduce[1]
//            let right = Int(operationsToReduce[2])!
//
//            if operand == "÷" && right == 0 {
//                delegate.warningMessage("You cannot divide by 0")
//                return
//            }
//
//            let result: Int
//            switch operand {
//            case "+": result = left + right
//            case "-": result = left - right
//            case "÷": result = left / right
//            case "×": result = left * right
//            default: fatalError("Unknown operator !")
//            }
//
//            operationsToReduce = Array(operationsToReduce.dropFirst(3))
//            operationsToReduce.insert("\(result)", at: 0)
//        }
//        stringWithData.append(" = \(operationsToReduce.first!)")
//        delegate.refreshTextViewWithValue(" = \(operationsToReduce.first!)")
//    }
    
//    func receiveNomberToCalculate (_ sender: UIButton){
//        guard let numberText = sender.title(for: .normal) else {return}
//        guard let delegate = viewDelegate else {return}
//
//        if testHaveResulta {
//            stringWithData = ""
//            delegate.refreshTextViewWithValue("")
//        }
//        stringWithData.append(numberText)
//        delegate.refreshTextViewWithValue(numberText)
//    }
    func doMathOperation() {
        if !expressionIsCorrect || !expressionHaveEnoughElement {
            return
        }
        
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            if operand == "÷" && right == 0 {
                viewDelegate?.warningMessage("You cannot divide by 0")
                return
            }
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "÷": result = left / right
            case "×": result = left * right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        stringWithData.append(" = \(operationsToReduce.first!)")
        viewDelegate?.refreshTextViewWithValue(" = \(operationsToReduce.first!)")
    }
    
    func receiveNomberToCalculate (_ sender: UIButton){
        guard let numberText = sender.title(for: .normal) else {return}
        
        if testHaveResulta {
            stringWithData = ""
            viewDelegate?.refreshTextViewWithValue("")
        }
        stringWithData.append(numberText)
        viewDelegate?.refreshTextViewWithValue(numberText)
    }
}
