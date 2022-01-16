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
            refreshCurrentStringWithData(type.rawValue)
        }
    }
    
    func doMathOperation() {
        if !expressionIsCorrect || !expressionHaveEnoughElement {
            return
        }
        
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int (operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int (operationsToReduce[2])!
            
            if operand == "÷" && right == 0 {
                viewDelegate?.warningMessage("You cannot divide by 0")
                resetStringWithData()
                return
            }
            
            var result: Double
            switch operand {
            case "+": result = Double(left) + Double(right)
            case "-": result = Double(left) - Double(right)
            case "÷": result = division(divisor: left, quotient: right)
            case "×": result = Double(left) * Double(right)
            default: return
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        refreshCurrentStringWithData(" = \(operationsToReduce.first!)")
    }
    
    func receiveNumberToCalculate (_ number: String) {
        if newCalcule {
            resetStringWithData()
        }
       refreshCurrentStringWithData(number)
    }
    
    func refreshCurrentStringWithData(_ data: String) {
        stringWithData.append(data)
        viewDelegate?.refreshTextViewWithValue(data)
    }
    
    func resetStringWithData() {
        stringWithData = ""
        viewDelegate?.resetTextviewText()
    }
    
    func resultatWithoutDecimal(_ resultat: Double) -> String {
        return String(format: "%.0f", resultat)
    }

    // MARK:-Testing Division
    func division (divisor: Int, quotient: Int) -> Double {
        var dividend: Double
        dividend =  Double(divisor) / Double(quotient)
        return dividend.roundedOneDecimal()
    }
    
    
//    func division(dato1: Int, dato2: Int) -> Double {
//        var resultado: Double
//        resultado = Double(dato1) / Double(dato2)
//        return resultado.roundedOneDecimal()
//    }
//
//
//    extension Double {
//        func roundedOneDecimal() -> Double {
//            return ((self * 10).rounded() / 10)
//        }
//    }
//
//    var resultaOfDivision = 0.0
//
//    resultaOfDivision = division(dato1: 9, dato2: 3)
    
}
