//
//  OperationsTestCase.swift
//  CountOnMeTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 28/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class OperationsTestCase: XCTestCase{
    var operations: Operations!
    
    override func setUp() {
        super.setUp()
        operations = Operations()
    }

   
    
    func testGivenNewMathOperation_WhenPressedAddtionButton_TheOperatorAdditionshouldBeHasAdd(){
        
        operations.testAddPlus()
        
        XCTAssert (operations.stringWithData.contains("+"))
        
    }
    
    
    func testGivenNewInstanceOfOperations_WhenAddSpaceToStringWithData_ThenStringWithDataHaveSpace() {
        operations.resetStringWithData()
        
        XCTAssert(operations.stringWithData.count == 0)
    }
    
    
    
//    func testGivenNewMathOperation_WhenPressedSubtractionButton_ThenOperatorSubtractionShouldBeAdd() {
//        weak var viewDelgate: ViewDelegate?
//        guard let delegate = viewDelgate else { return }
//
//        operations.addSubtractionOperator()
//
//        XCTAssert (delegate.textView.text.contains(" - "))
//    }
    
//    func testGivenNewMathOperation_WhenPressedMultiplicationButton_TheOperatorMultiplicationShouldBeAdd() {
//        weak var viewDelgate: ViewDelegate?
//        guard let delegate = viewDelgate else { return }
//
//        operations.addMultiplicationOperator()
//
//        XCTAssert (delegate.textView.text.contains(" × "))
//    }
}

//extension OperationsTestCase {
//    func warningMessage(_ message: String) {
//    }
//
//    func addResultat(_ resultat: String) {
//    }
//
//    func addMathematicalOperator(_ mathematicalOperator: String) {
//    }
//
//    func addCharacterToTextView(_ char: String) {
//    }
//
//}

//internal class Operations {
//
//    weak internal var viewDelegate: ViewDelegate?
//
//    internal func addAdditionOperator()
//
//    internal func addSubtractionOperator()
//
//    internal func addMultiplicationOperator()
//
//    internal func addDivisionOperator()
//
//    internal func resetStringWithData()
//
//    internal func equalButton()
//
//    internal func receiveNomberToCalculate(_ sender: UIButton)
//}
//carry out a new math operation
