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
    var textWhitData: [String] {
        viewDelegate!.elements
    }
    
    private var expressionIsCorrect: Bool {
        return textWhitData.last != "+" && textWhitData.last != "-"
            && textWhitData.last != "×" && textWhitData.last != "÷"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return textWhitData.count >= 3
    }
    
    private var canAddOperator: Bool {
        return textWhitData.last != "+" && textWhitData.last != "-"
            && textWhitData.last != "×" && textWhitData.last != "÷"
    }
    
    // MARK: - Constants
    let message = "Un operateur est déjà mis !"
  
    
    //MARK: - Functions
    func addition(){
        if viewDelegate!.canAddOperator {
            viewDelegate?.addMathematicalOperator(" + ")
        } else {
            viewDelegate?.warningMessage(message)
        }
    }
    
    func subtraction(){
        if viewDelegate!.canAddOperator {
            viewDelegate?.addMathematicalOperator(" - ")
        } else {
            viewDelegate?.warningMessage(message)
        }
    }
    
    func multiplication(){
        if viewDelegate!.canAddOperator {
            viewDelegate?.addMathematicalOperator(" × ")
        } else {
            viewDelegate?.warningMessage(message)
        }
    }
    
    func division(){
        if viewDelegate!.canAddOperator {
            viewDelegate?.addMathematicalOperator(" ÷ ")
        } else {
            viewDelegate?.warningMessage(message)
        }
    }
    
    func equalButton() {
        
        //pas de ! dans delegate -> cast
        guard let delegate = viewDelegate else {return}
        guard expressionIsCorrect else {
            delegate.warningMessage("Entrez une expression correcte !"); return}
        guard expressionHaveEnoughElement else {
            delegate.warningMessage("Démarrez un nuveau calcul !"); return}
        
        var operationsToReduce = delegate.elements
        
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
}
