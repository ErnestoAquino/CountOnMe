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
    
    private var stringWithData: String = ""
    
    private var testElementos: [String] {
        return stringWithData.split(separator: " ").map { "\($0)" }
    }
    
    private var testHaveResulta: Bool {
        return stringWithData.firstIndex(of: "=") != nil
    }

    private var canAddOperator: Bool {
        return testElementos.last != "+" && testElementos.last != "-"
            && testElementos.last != "×" && testElementos.last != "÷"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return testElementos.count >= 3
    }
    
    private var expressionIsCorrect: Bool {
        return testElementos.last != "+" && testElementos.last != "-"
            && testElementos.last != "×" && testElementos.last != "÷"
    }
    // MARK: - Constants
    private let message = "Un operateur est déjà mis !"
  
    
    //MARK: - Functions
    func addition(){
        guard let delegate = viewDelegate else {return}
        if canAddOperator {
            delegate.addMathematicalOperator(" + ")
            stringWithData.append(" + ")
        } else {
            delegate.warningMessage(message)
        }
    }
    
    func subtraction(){
        guard let delegate = viewDelegate else {return}
        if canAddOperator {
            delegate.addMathematicalOperator(" - ")
            stringWithData.append(" - ")
        } else {
            delegate.warningMessage(message)
        }
    }
    
    func multiplication(){
        guard let delegate = viewDelegate else {return}
        if canAddOperator {
            delegate.addMathematicalOperator(" × ")
            stringWithData.append(" × ")
        } else {
            delegate.warningMessage(message)
        }
    }
    
    func division(){
        guard let delegate = viewDelegate else {return}
        if canAddOperator {
            delegate.addMathematicalOperator(" ÷ ")
            stringWithData.append(" ÷ ")
        } else {
            delegate.warningMessage(message)
        }
    }
    
    func resetStringWithData () {
        stringWithData = ""
    }
    
    func equalButton() {
        guard let delegate = viewDelegate else {return}
        guard expressionIsCorrect else {
            delegate.warningMessage("Entrez une expression correcte !"); return}
        guard expressionHaveEnoughElement else {
            delegate.warningMessage("Démarrez un nuveau calcul !"); return}
        
        var operationsToReduce = testElementos
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            if operand == "÷" && right == 0 {
                delegate.warningMessage("You cannot divide by 0")
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
        delegate.addResultat(" = \(operationsToReduce.first!)")
    }
    
    func receiveNomberToCalculate (_ sender: UIButton){
        guard let numberText = sender.title(for: .normal) else {return}
        guard let delegate = viewDelegate else {return}
        
        if testHaveResulta {
            stringWithData = ""
            delegate.addResultat("")
        }
        stringWithData.append(numberText)
        delegate.addCharacterToTextView(numberText)
    }
    
}
