//
//  Operations.swift
//  CountOnMe
//
//  Created by Ernesto Elias on 22/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation


class Operations {
    
    public private(set) var currenteValue: Int = 15
    
    weak var viewDelegate: ViewDelegate?
    
    func clear() {
        viewDelegate?.clear()
        print("im here")
    }
    
    func addition(){
        if viewDelegate!.canAddOperator {
            viewDelegate?.addition()
        } else {
            viewDelegate?.warningMessage("Un operateur est déja mis !")
        }
    }
    
    func subtraction(){
        if viewDelegate!.canAddOperator {
            viewDelegate?.subtraction()
        } else {
            viewDelegate?.warningMessage("Un operateur est déja mis!")
        }
    }
    
    func multiplication(){
        if viewDelegate!.canAddOperator {
            viewDelegate?.multiplication()
        } else {
            viewDelegate?.warningMessage("Un operateur est déja mis")
        }
    }
    
    func division(){
        if viewDelegate!.canAddOperator {
            viewDelegate?.division()
        } else {
            viewDelegate?.warningMessage("Un operateur est déja mis")
        }
    }
    
    func equalButton() {
        guard viewDelegate!.expressionIsCorrect else {
            viewDelegate?.warningMessage("Entrez une expression correcte !"); return}
        guard viewDelegate!.expressionHaveEnoughElement else {
            viewDelegate?.warningMessage("Démarrez un nuveau calcul !"); return}
        
        var operationsToReduce = viewDelegate!.elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
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
        
        viewDelegate?.addResultat(operationsToReduce)
    }

}
