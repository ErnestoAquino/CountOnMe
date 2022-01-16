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
    
    var mockDelegate: MockDelegate!
    var operations: Operations!

    
    override func setUp() {
        super.setUp()
        operations = Operations()
        mockDelegate = MockDelegate()
        operations.viewDelegate = mockDelegate
    }

    
    
    func testGivenNewMathOperation_WhenPressedAddtionButton_TheOperatorAdditionShouldBeHasAdd(){
        operations.addOperator(type: .addition)

        XCTAssertTrue (operations.stringWithData.contains("+"))
    }
    
    func testGivenNewMathOperation_WhenPressedSubtractionButton_TheOperatorSubtractionShouldBeHasAdd(){
        operations.addOperator(type: .subtraction)

        XCTAssertTrue (operations.stringWithData.contains("-"))
    }
    
    func testGivenNewMathOperation_WhenPressedMultiplicationButton_TheOperatorMultiplicationShouldBeHasAdd(){
        operations.addOperator(type: .multiplication)

        XCTAssertTrue (operations.stringWithData.contains("×"))
    }
    
    func testGivenNewMathOperation_WhenPressedDivisionButton_TheOperatorDivisionShouldBeHasAdd(){
        operations.addOperator(type: .division)

        XCTAssertTrue (operations.stringWithData.contains("÷"))
    }
    
    func testGivenStringWithCalcule_WhenPressedAcButton_ThenStringShoulbeEmpty(){
        operations.receiveNumberToCalculate("4")
        operations.addOperator(type: .addition)
        operations.receiveNumberToCalculate("8")
       
        operations.resetStringWithData()
        
        XCTAssertTrue (operations.stringWithData.count == 0)
    }
    
    func testGivenIncompleteCalcule_WhenPressButtonEqual_ThenCalculeNotDone(){
        operations.receiveNumberToCalculate("4")
        operations.addOperator(type: .addition)
        
        operations.doMathOperation()
        
        XCTAssertFalse(operations.expressionHaveEnoughElement)
    }
    
    func testGivenFourPlusEight_WhenPressButtonEqual_ThenResultIsEqualTwelve(){
        operations.receiveNumberToCalculate("4")
        operations.addOperator(type: .addition)
        operations.receiveNumberToCalculate("8")
        
        operations.doMathOperation()

        XCTAssertTrue(operations.stringWithData.contains(" = 12"))
    }
    
    func testGivenEightMinusFour_WhenPressButtonEqual_ThenResultIsEqualFour(){
        operations.receiveNumberToCalculate("8")
        operations.addOperator(type: .subtraction)
        operations.receiveNumberToCalculate("4")
        
        operations.doMathOperation()
        
        XCTAssertTrue(operations.stringWithData.contains(" = 4"))
    }
    
    func testGivenEightTimesFour_WhenPressButtonEqual_ThenResultatIsEqualthirtyTwo(){
        operations.receiveNumberToCalculate("8")
        operations.addOperator(type: .multiplication)
        operations.receiveNumberToCalculate("4")
        
        operations.doMathOperation()
        
        XCTAssertTrue(operations.stringWithData.contains(" = 32"))
    }
    
    func testGivenEightDivideByFour_WhenPressButtonEqual_ThenResultatShouldBeTwo() {
        operations.receiveNumberToCalculate("8")
        operations.addOperator(type: .division)
        operations.receiveNumberToCalculate("4")
        
        operations.doMathOperation()
        
        XCTAssertTrue(operations.stringWithData.contains(" = 2"))
    }
    
    
    func testMessage(){
        let mockDelegate = MockDelegate()
        operations.viewDelegate = mockDelegate
        
        mockDelegate.warningMessage("")
        
        XCTAssert(mockDelegate.warningMessageIsCalled)
    }
    
    func testGivenDivisionByZero_WhenPressButtoEqual_ThenWarningMessageIsCalled() {
        operations.receiveNumberToCalculate("8")
        operations.addOperator(type: .division)
        operations.receiveNumberToCalculate("0")
        
        operations.doMathOperation()
        
        XCTAssertTrue(mockDelegate.warningMessageIsCalled)
    }
    
    func testGivenAnCalculationHasFinished_GivenPressButtonWithNumber_TheNewCalculationBegins() {
        operations.receiveNumberToCalculate("4")
        operations.addOperator(type: .addition)
        operations.receiveNumberToCalculate("8")
        operations.doMathOperation()
        
        operations.receiveNumberToCalculate("0")
        
        XCTAssertTrue(mockDelegate.resetTextviewTextIsCalled)
    }
}
