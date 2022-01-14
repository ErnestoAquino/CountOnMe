//
//  Operations.swift
//  CountOnMe
//
//  Created by Ernesto Elias on 22/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation



class Operations {
    
    // MARK: - Variables
    weak var viewDelegate: ViewDelegate?
    
    private var newCalcule: Bool {
        return stringWithData.contains("=")
    }
    private (set) var stringWithData: String = ""
    
    private var elements: [String] {
        return stringWithData.split(separator: " ").map { "\($0)" }
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
        if canAddOperator{
            stringWithData.append(type.rawValue)
            viewDelegate?.refreshTextViewWithValue(type.rawValue)
        }
    }
    
    func resetStringWithData () {
        stringWithData = ""
    }
    
    func doMathOperation() {
        if !expressionIsCorrect || !expressionHaveEnoughElement {
            return
        }
        
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            
            if operand == "÷" && right == 0 {
                viewDelegate?.warningMessage("You cannot divide by 0")
                return
            }
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "÷": result = left / right
            case "×": result = left * right
//            default: fatalError("Unknown operator !") -> ALerte
            default: return
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        stringWithData.append(" = \(operationsToReduce.first!)")
        viewDelegate?.refreshTextViewWithValue(" = \(operationsToReduce.first!)")
    }
    
//    -> To controller pas uikit
//    func receiveNomberToCalculate (_ sender: UIButton){
//        guard let numberText = sender.title(for: .normal) else {
//            viewDelegate?.warningMessage("This button has not number!")
//            return
//        }
//        if newCalcule {
//            resetStringWithData()
//            viewDelegate?.resetTextviewText()
//        }
//        stringWithData.append(numberText)
//        viewDelegate?.refreshTextViewWithValue(numberText)
//    }
    
    func receiveNumberToCalculate (_ number: String) {
        if newCalcule {
            resetStringWithData()
            viewDelegate?.resetTextviewText()
        }
        stringWithData.append(number)
        viewDelegate?.refreshTextViewWithValue(number)
    }
}
