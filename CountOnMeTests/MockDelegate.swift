//
//  MockDelegate.swift
//  CountOnMeTests
//
//  Created by Ernesto Elias on 14/01/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation
@testable import CountOnMe

class MockDelegate: ViewDelegate {
    
    
    var warningMessageIsCalled = false
    var refreshTextViewWhitValueIsCalled = false
    var resetTextviewTextIsCalled = false
    
    
    func warningMessage(_ message: String) {
        warningMessageIsCalled = true
    }
    
    func refreshTextViewWithValue(_ value: String) {
        refreshTextViewWhitValueIsCalled = true
    }
    
    func resetTextviewText() {
        resetTextviewTextIsCalled = true
    }
}
