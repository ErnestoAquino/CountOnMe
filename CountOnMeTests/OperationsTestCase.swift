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
    var buttonFour:  UIButton!
    var buttonEight: UIButton!
    var buttonZero: UIButton!
    
    override func setUp() {
        super.setUp()
        operations = Operations()
        mockDelegate = MockDelegate()
        operations.viewDelegate = mockDelegate
        buttonFour = UIButton()
        buttonFour.setTitle("4", for: .normal)
        buttonEight = UIButton()
        buttonEight.setTitle("8", for: .normal)
        buttonZero = UIButton()
        buttonZero.setTitle("0", for: .normal)
        
    }

    
    
    func testGivenNewMathOperation_WhenPressedAddtionButton_TheOperatorAdditionShouldBeHasAdd(){
        operations.addOperator(type: .addition)

        XCTAssert (operations.stringWithData.contains("+"))
    }
    
    func testGivenNewMathOperation_WhenPressedSubtractionButton_TheOperatorSubtractionShouldBeHasAdd(){
        operations.addOperator(type: .subtraction)

        XCTAssert (operations.stringWithData.contains("-"))
    }
    
    func testGivenNewMathOperation_WhenPressedMultiplicationButton_TheOperatorMultiplicationShouldBeHasAdd(){
        operations.addOperator(type: .multiplication)

        XCTAssert (operations.stringWithData.contains("×"))
    }
    
    func testGivenNewMathOperation_WhenPressedDivisionButton_TheOperatorDivisionShouldBeHasAdd(){
        operations.addOperator(type: .division)

        XCTAssert (operations.stringWithData.contains("÷"))
    }
    
    func testGivenStringWithCalcule_WhenPressedAcButton_ThenStringShoulbeEmpty(){
        operations.receiveNomberToCalculate(buttonFour)
        operations.addOperator(type: .addition)
        operations.receiveNomberToCalculate(buttonEight)
       
        operations.resetStringWithData()
        
        XCTAssert(operations.stringWithData.count == 0)
    }
    
    func testGivenIncompleteCalcule_WhenPressButtonEqual_ThenCalculeNotDone(){
        operations.receiveNomberToCalculate(buttonFour)
        operations.addOperator(type: .addition)
        
        operations.doMathOperation()
        
        XCTAssertFalse(operations.expressionHaveEnoughElement)
    }
    
    func testGivenFourPlusEight_WhenPressButtonEqual_ThenResultIsEqualTwelve(){
        operations.receiveNomberToCalculate(buttonFour)
        operations.addOperator(type: .addition)
        operations.receiveNomberToCalculate(buttonEight)
        
        operations.doMathOperation()

        XCTAssertTrue(operations.stringWithData.contains(" = 12"))
    }
    
    func testGivenEightMinusFour_WhenPressButtonEqual_ThenResultIsEqualFour(){
        operations.receiveNomberToCalculate(buttonEight)
        operations.addOperator(type: .subtraction)
        operations.receiveNomberToCalculate(buttonFour)
        
        operations.doMathOperation()
        
        XCTAssert(operations.stringWithData.contains(" = 4"))
    }
    
    func testGivenEightTimesFour_WhenPressButtonEqual_ThenResultatIsEqualthirtyTwo(){
        operations.receiveNomberToCalculate(buttonFour)
        operations.addOperator(type: .multiplication)
        operations.receiveNomberToCalculate(buttonEight)
        
        operations.doMathOperation()
        
        XCTAssert(operations.stringWithData.contains(" = 32"))
    }
    
    func testGivenEightDivideByFour_WhenPressButtonEqual_ThenResultatShouldBeTwo() {
        operations.receiveNomberToCalculate(buttonEight)
        operations.addOperator(type: .division)
        operations.receiveNomberToCalculate(buttonFour)
        
        operations.doMathOperation()
        
        XCTAssert(operations.stringWithData.contains(" = 2"))
    }
    
    
    func testMessage(){
        let mockDelegate = MockDelegate()
        operations.viewDelegate = mockDelegate
        
        mockDelegate.warningMessage("")
        
        XCTAssert(mockDelegate.warningMessageIsCalled)
    }
    
    func testGivenDivisionByZero_WhenPressButtoEqual_ThenWarningMessageIsCalled() {
//        let mockDelegate = MockDelegate()
//        operations.viewDelegate = mockDelegate
        operations.receiveNomberToCalculate(buttonEight)
        operations.addOperator(type: .division)
        operations.receiveNomberToCalculate(buttonZero)
        
        operations.doMathOperation()
        
        XCTAssert(mockDelegate.warningMessageIsCalled)
    }
    
    func testGivenFourPlus_WhenAddAnotherOperatorPlus_ThenWarningMessageIsCalled() {
//        let mockDelegate = MockDelegate()
//        operations.viewDelegate = mockDelegate
        operations.receiveNomberToCalculate(buttonFour)
        operations.addOperator(type: .addition)
      
        operations.addOperator(type: .addition)
        
        XCTAssert(mockDelegate.warningMessageIsCalled)
    }
    
    func testGivenButtonWithoutNumber_WhenPressButtonWithoutNumber_ThenNothingIsAdded() {
        let buttonWithoutNumber: UIButton = UIButton()
        buttonWithoutNumber.setTitle("", for: .normal)
        
        operations.receiveNomberToCalculate(buttonWithoutNumber)
        
        XCTAssert(operations.stringWithData.count == 0)
    }
    
    
    
    
    
        
    
}


// MARK:- MockDelegate

class MockDelegate: ViewDelegate {
    var warningMessageIsCalled = false
    var refreshTextViewWhitValueIsCalled = false
    
    
    func warningMessage(_ message: String) {
        warningMessageIsCalled = true
    }
    
    func refreshTextViewWithValue(_ value: String) {
        refreshTextViewWhitValueIsCalled = true
    }
}
