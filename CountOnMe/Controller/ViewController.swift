//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewDelegate {
      
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorsButtons: [UIButton]!
        
    // MARK: - Constants
    
    let operations = Operations()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        operations.viewDelegate = self
        resetTextviewText()
        //UI
        numberButtons.forEach{
            $0.round()
        }
        operatorsButtons.forEach{
            $0.round()
        }
        numberButtons[0].tag = 1
    }
    
    //MARK: - View actions
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        pressNumberButton(sender)
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        operations.resetStringWithData()
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        operations.addOperator(type: .addition)
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        operations.addOperator(type: .subtraction)
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        operations.addOperator(type: .multiplication)
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        operations.addOperator(type: .division)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        operations.doMathOperation()
    }
    
    //MARK: - Functions // retire pour etre punitive
    internal func warningMessage(_ message: String){
        let warningMessage = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        warningMessage.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(warningMessage, animated: true, completion: nil)
    }
    
     internal func resetTextviewText() {
        textView.text = ""
    }
    
    
    internal func refreshTextViewWithValue(_ value: String){
        textView.text.append(value)
    }
    
    internal func pressNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            warningMessage("This button has not number")
            return
        }
        operations.receiveNumberToCalculate(numberText)
    }
}
