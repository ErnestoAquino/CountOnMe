//
//  OperationsTestCase.swift
//  CountOnMeTests
//
//  Created by Ernesto Elias Aquino Cifuentes on 28/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class OperationsTestCase: XCTestCase {
    
//    func testGivenAnString_WhenClear_TheStringShoudBeHasNothing() {
//        weak var viewDelegate: ViewDelegate?
//        let operations = Operations()
//
//
//
//    }

    
    func testGivenAnString_WhenTappedAddtionButton_TheOperatorAdditionshouldBeHasAdd(){
        weak var viewDelgate: ViewDelegate?
        guard let delegate = viewDelgate else { return }
        
        delegate.addMathematicalOperator(" + ")
        
        
    }
}


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
