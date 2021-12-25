//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

//Delegate pattern autre fichier
protocol ViewDelegate: AnyObject {
    func updateview()
}

class ViewController: UIViewController, ViewDelegate {
    public func updateview() {
        
    }
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorsButtons: [UIButton]!
    
    // MARK: - Variables
    private var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    private var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // MARK: - Constants
    
    let operations = Operations()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        operations.viewDelegate = self
        //UI
        for button in numberButtons{
            button.round()
        }
        for button in operatorsButtons{
            button.round()
        }
    }
    
    //MARK: - View actions
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        clear()
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        addition()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
       subtraction()
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        multiplication()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        division()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else { 
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
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
        
        textView.text.append(" = \(operationsToReduce.first!)")
    }
    
    
    private func warningMessage(_ message: String){
        let warningMessage = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        warningMessage.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(warningMessage, animated: true, completion: nil)
    }
    
    //clean the screen 
    private func clear() {
        textView.text = ""
    }
    
    private func addition(){
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            warningMessage("Un operateur est déja mis !")
        }
    }
    
    private func subtraction() {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            warningMessage("Un operateur est déja mis !")
        }
    }
    
    private func multiplication() {
        if canAddOperator {
            textView.text.append(" × ")
        } else {
            warningMessage("Un operateur est déja mis !")
        }
    }
    
    private func division() {
        if canAddOperator {
            textView.text.append(" ÷ ")
        } else {
            warningMessage("Un operateur est déja mis !")
        }
    }

}

