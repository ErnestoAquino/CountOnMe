//
//  Operations.swift
//  CountOnMe
//
//  Created by Ernesto Elias on 22/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//
// Class to solve mathematical operations.

import Foundation

class Operations {
    
    // MARK: - Constants
    enum OperatorType: String {
        case addition = " + "
        case subtraction = " - "
        case multiplication = " × "
        case division = " ÷ "
    }
    
    // MARK: - Variables
    weak var viewDelegate: ViewDelegate?
    private var negativeOperation = false
    // This property stores the data to perform the mathematical operation
    private (set) var stringWithData: String = ""
   
    private var newCalcule: Bool {
        return stringWithData.contains("=")
    }
    
    private var elements: [String] {
        return stringWithData.split(separator: " ").map { "\($0)" }
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "×" && elements.last != "÷"
            && stringWithData.count != 0
    }
    
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "×" && elements.last != "÷"
    }
    
    internal var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
   
    
    //MARK: - Functions

    internal func addOperator(type: OperatorType) {
        if stringWithData == "" && type == .subtraction {
            refreshCurrentStringWithData(type.rawValue)
        }
        if canAddOperator{
            refreshCurrentStringWithData(type.rawValue)
        }
    }
    
    internal func receiveNumberToCalculate (_ number: String) {
        if newCalcule {
            resetStringWithData()
        }
       refreshCurrentStringWithData(number)
    }
    
   /// Does the arithmetic operation(s) to obtain the final result.
    ///*  Check if the conditions are valid (expressionIsCorrect, expressionHaveEnoughElement , newCalcule)
    ///* Analyze if the first number is negative.
    ///* It makes the priority operations.
    ///* Does the remaining Operations.
    ///* Get the result.
    internal func doMathOperation() {
        if !expressionIsCorrect || !expressionHaveEnoughElement || newCalcule {
            return
        }
    
        var operationsToReduce = elements
        
        //Check if the calculation is negative and modify the property: negativeOperation if it is true
        if operationsToReduce.first == "-" {
            negativeOperation = true
            operationsToReduce.remove(at: 0)
        }
        // Does the priority arithmetic operations "×" and "÷" if they exist. Call warningMessage if dividing by zero is being attempted.
        while operationsToReduce.contains("×") || operationsToReduce.contains("÷"){
            guard let index = operationsToReduce.firstIndex(where: {$0 == "×" || $0 == "÷"}) else {return}
            if operationsToReduce[index] == "÷" && operationsToReduce[index + 1] == "0"{
                viewDelegate?.warningMessage("You cannot divide by 0")
                resetStringWithData()
                return
            }
            let resultPriorityCalculation = calculate(operationsToReduce[index - 1], operationsToReduce[index], operationsToReduce[index + 1])
            if resultContainSignificantDecimals(resultPriorityCalculation){
                let resultPriotrityHowInt = Int(resultPriorityCalculation)
                operationsToReduce[index] = "\(resultPriotrityHowInt)"
            } else {
                operationsToReduce[index] = "\(resultPriorityCalculation)"
            }
            operationsToReduce.remove(at: index + 1)
            operationsToReduce.remove(at: index - 1)
        }

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let result =  calculate(operationsToReduce[0], operationsToReduce[1], operationsToReduce[2])
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            if resultContainSignificantDecimals(result){
                let resultHowInt = Int(result)
                operationsToReduce.insert("\(resultHowInt)", at: 0)
            } else {
                operationsToReduce.insert("\(result)", at: 0)
            }
        }
        refreshCurrentStringWithData(" = \(operationsToReduce.first ?? "error")")
    }
    
    internal func resetStringWithData() {
        stringWithData = ""
        viewDelegate?.resetTextviewText()
    }
    
    /// Returns the result of the arithmetic operation as a double with a single decimal
    ///
    ///- Parameter left:  first argument of arithmetic operation like String
    ///- Parameter operand: Type of arithmetic operation. Can be "-", "+", "÷", "×".
    ///- Parameter right: Second argument of the arithmetic operation like String.
    ///- Returns: Returns the result of the arithmetic operation as a double is a single decimal.
    
    private func calculate(_ left: String, _ operand: String, _ right: String) -> Double {
           guard var left = Double(left) else { return Double() }
           let operand = operand
           guard let right = Double(right) else { return Double() }
            
        if negativeOperation {
            left = left * -1.0
            negativeOperation = false
        }
        
        let result: Double
           switch operand {
           case "+": result = left + right
           case "-": result = left - right
           case "÷": result = left / right
           case "×": result = left * right
           default: return Double()
           }
        return result.roundedOneDecimal()
    }
    
    private func refreshCurrentStringWithData(_ data: String) {
        stringWithData.append(data)
        viewDelegate?.refreshTextViewWithValue(data)
    }
    
    /// Check if a double number contains important decimals.
    /// It does a double cast to do the check.
    /// - Parameter result: Number to check.
    /// - Returns: Returns true if the number has decimals that are different from zero
    
    private  func resultContainSignificantDecimals (_ result: Double) -> Bool {
        if result == Double(Int(result)){
            return true
        }
        return false
    }
}
