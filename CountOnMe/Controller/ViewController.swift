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
    }
    
    //MARK: - View actions
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        operations.receiveNomberToCalculate(sender)
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        resetTextviewText()
        operations.resetStringWithData()
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        operations.addAdditionOperator()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        operations.addSubtractionOperator()
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        operations.addMultiplicationOperator()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        operations.addDivisionOperator()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        operations.equalButton()
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
    
    internal func addResultat(_ resultat: String) {
        textView.text.append(resultat)
    }
    
    internal func addMathematicalOperator(_ mathematicalOperator: String){
        textView.text.append(mathematicalOperator)
    }
    
    internal func addCharacterToTextView (_ char: String) {
        textView.text.append(char)
    }
    
    
    //une seul methode pour les 3 functions refresh textview with
}
