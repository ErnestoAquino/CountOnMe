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
    
    private var negativeOperation = false
    
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
            && stringWithData.count != 0
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

    internal func addOperator(type: OperatorType) {
        if stringWithData == "" && type == .subtraction {
            refreshCurrentStringWithData(type.rawValue)
        }
        if canAddOperator{
            refreshCurrentStringWithData(type.rawValue)
        }
    }
    
    internal func doMathOperation() {
        if !expressionIsCorrect || !expressionHaveEnoughElement || newCalcule {
            return
        }
    
        var operationsToReduce = elements
        
        if operationsToReduce.first == "-" {
            negativeOperation = true
            operationsToReduce.remove(at: 0)
        }
        
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
        refreshCurrentStringWithData(" = \(operationsToReduce.first!)")
    }
    
    
    private func calculate(_ left: String, _ operand: String, _ right: String) -> Double {
           guard var left = Double(left) else { return Double() }
           let operand = operand
           guard let right = Double(right) else { return Double() }
            
        if negativeOperation {
            left = left * -1.0
            negativeOperation = false
        }
        
        var resultado: Double
           switch operand {
           case "+": resultado = left + right
           case "-": resultado = left - right
           case "÷": resultado = left / right
           case "×": resultado = left * right
           default: return Double()
           }
        return resultado.roundedOneDecimal()
    }
    
    
    internal func receiveNumberToCalculate (_ number: String) {
        if newCalcule {
            resetStringWithData()
        }
       refreshCurrentStringWithData(number)
    }
    
    private func refreshCurrentStringWithData(_ data: String) {
        stringWithData.append(data)
        viewDelegate?.refreshTextViewWithValue(data)
    }
    
    internal func resetStringWithData() {
        stringWithData = ""
        viewDelegate?.resetTextviewText()
    }
    
    //result contains significant decimals
  private  func resultContainSignificantDecimals (_ result: Double) -> Bool {
        if result == Double(Int(result)){
            return true
        }
        return false
    }
}
