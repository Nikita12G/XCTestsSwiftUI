//
//  XCTestExTests.swift
//  CalculatorTests
//
//  Created by Никита Гуляев on 14.08.2024.
//

import XCTest

@testable import XCTestsSwiftUI

final class CalculatorTests: XCTestCase {

    var calculator: Calculator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        calculator = Calculator()
    }

    override func tearDownWithError() throws {
        calculator = nil
        try super.tearDownWithError()
    }

    func testAddition() throws {
        let result = calculator.add(3, 2)
        XCTAssertEqual(result, 5, "Expected 3 + 2 to equal 5")
    }

    func testSubtraction() throws {
        let result = calculator.subtract(5, 3)
        XCTAssertEqual(result, 2, "Expected 5 - 3 to equal 2")
    }

    func testMultiplication() throws {
        let result = calculator.multiply(4, 3)
        XCTAssertEqual(result, 12, "Expected 4 * 3 to equal 12")
    }

    func testDivision() throws {
        let result = calculator.divide(10, 2)
        XCTAssertEqual(result, 5, "Expected 10 / 2 to equal 5")
    }
}
