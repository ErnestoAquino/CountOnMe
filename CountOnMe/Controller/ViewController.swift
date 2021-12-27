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
    func clear()
    func addition()
    func subtraction()
    func multiplication()
    func division()
    func warningMessage(_ message: String)
    func addResultat(_ operationsToReduce: [String])
    
    var canAddOperator: Bool {get}
    var expressionIsCorrect: Bool {get}
    var expressionHaveEnoughElement: Bool {get}
    var expressionHaveResult: Bool {get}
    var elements: [String] {get}
}

class ViewController: UIViewController, ViewDelegate {
      
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorsButtons: [UIButton]!
    
    // MARK: - Variables
    internal var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    internal var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "×" && elements.last != "÷"
    }
    
    internal var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    internal var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "×" && elements.last != "÷"
    }

    internal var expressionHaveResult: Bool {
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
//        clear()
        operations.clear()
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        operations.addition()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        operations.subtraction()
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        operations.multiplication()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        operations.division()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
//        guard expressionIsCorrect else { warningMessage("Entrez une expression correcte !"); return}
//
//        guard expressionHaveEnoughElement else { warningMessage("Démarrez un nouveau calcul !"); return}
//
//        // Create local copy of operations
//        var operationsToReduce = elements
//
//        // Iterate over operations while an operand still here
//        while operationsToReduce.count > 1 {
//            let left = Int(operationsToReduce[0])!
//            let operand = operationsToReduce[1]
//            let right = Int(operationsToReduce[2])!
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
//
//        textView.text.append(" = \(operationsToReduce.first!)")
        operations.equalButton()
    }
    
    //MARK: - Functions
    internal func warningMessage(_ message: String){
        let warningMessage = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        warningMessage.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(warningMessage, animated: true, completion: nil)
    }
    
    //clean the screen 
     internal func clear() {
        textView.text = ""
    }
    
//    internal func addition(){
//        if canAddOperator {
//            textView.text.append(" + ")
//        } else {
//            warningMessage("Un operateur est déja mis !")
//        }
//    }
    
    internal func addition(){
            textView.text.append(" + ")
    }
    
//    internal func subtraction() {
//        if canAddOperator {
//            textView.text.append(" - ")
//        } else {
//            warningMessage("Un operateur est déja mis !")
//        }
//    }
    
    internal func subtraction(){
        textView.text.append(" - ")
    }
    
//    private func multiplication() {
//        if canAddOperator {
//            textView.text.append(" × ")
//        } else {
//            warningMessage("Un operateur est déja mis !")
//        }
//    }
    internal func multiplication() {
        textView.text.append(" × ")
    }
    
//    private func division() {
//        if canAddOperator {
//            textView.text.append(" ÷ ")
//        } else {
//            warningMessage("Un operateur est déja mis !")
//        }
//    }
    
    internal func division() {
        textView.text.append(" ÷ ")
    }
    
    internal func addResultat(_ operationsToReduce: [String]) {
        textView.text.append(" = \(operationsToReduce.first!)")
    }

}

