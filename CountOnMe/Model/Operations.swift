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
        
        while operationsToReduce.contains("×") || operationsToReduce.contains("÷"){
            guard let index = operationsToReduce.firstIndex(where: {$0 == "×" || $0 == "÷"}) else {return}
            if operationsToReduce[index] == "÷" && operationsToReduce[index + 1] == "0"{
                viewDelegate?.warningMessage("You cannot divide by 0")
                resetStringWithData()
                return
            }
            let resultPriorityCalculation = calculate(operationsToReduce[index - 1], operationsToReduce[index], operationsToReduce[index + 1])
            operationsToReduce[index] = "\(resultPriorityCalculation)"
            operationsToReduce.remove(at: index + 1)
            operationsToReduce.remove(at: index - 1)
        }
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
//            guard let left = Int(operationsToReduce[0]) else {return}
//            let operand = operationsToReduce[1]
//            guard let right = Int(operationsToReduce[2]) else {return}
//
//            if operationsToReduce[1] == "÷" && operationsToReduce[2] == "0" {
//                print("Enter aqui")
//                viewDelegate?.warningMessage("You cannot divide by 0")
//                resetStringWithData()
//                return
//            }

//            var result: Double
//            switch operand {
//            case "+": result = Double(left) + Double(right)
//            case "-": result = Double(left) - Double(right)
//            case "÷": result = division(divisor: left, quotient: right)
//            case "×": result = Double(left) * Double(right)
//            default: return
//            }
            let result =  calculate(operationsToReduce[0], operationsToReduce[1], operationsToReduce[2])
            
//            let resultString = resultatWithoutDecimal(result)
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
//            if operand != "÷" {
//                operationsToReduce.insert("\(resultString)", at: 0)
//            } else {
//                operationsToReduce.insert("\(result)", at: 0)
//            }
            operationsToReduce.insert("\(result)", at: 0)
        }
        refreshCurrentStringWithData(" = \(operationsToReduce.first!)")
    }
    
    //MARK:- Testint Space

    private func calculate(_ left: String, _ operand: String, _ right: String) -> Double {
           guard let left = Double(left) else { return Double() }
           let operand = operand
           guard let right = Double(right) else { return Double() }
        
        var resultado: Double
           switch operand {
           case "+": resultado = Double(left) + Double(right)
           case "-": resultado = Double(left) - Double(right)
           case "÷": resultado = (left / right).roundedOneDecimal()
           case "×": resultado = Double(left) * Double(right)
           default: return Double()
           }
        return resultado
       }

    
    //MARK:- Testing Space End
    
    
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
}




//import UIKit
//
//var greeting = "Hello, playground"
//
//
//var left = "q"
//var rigth = "3"
//
//var resultado = 0.0
//
//
//func sumatoriom(lesft: String, right: String) -> Double {
//    guard let leftInt = Double(left) else { return Double() }
//    guard let rigthInt = Double(rigth) else { return Double()}
//    
//    let resultado = leftInt + rigthInt
//    return resultado
//}
//
//
//resultado = sumatoriom(lesft: left, right: rigth)
//
//
//var pruebaDouble = 13.23
//
//print(String(format: "%.0f", pruebaDouble))
//
//var pruebaRedondeado = pruebaDouble.rounded()
//
//
//if pruebaDouble == Double(Int(pruebaDouble)) {
//// The value doesn't have decimal part. ex: 6.0
//    print ("No tiene ceros")
//    print(pruebaDouble)
//    print(Int(pruebaDouble))
//} else {
////  The value has decimal part. ex: 6.3
//    print("Tiene otro valor")
//    print(pruebaDouble)
//    print(Int(pruebaDouble))
//    print(Double(Int(pruebaDouble)))
//}
//
