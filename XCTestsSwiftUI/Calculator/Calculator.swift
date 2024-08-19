//
//  Calculator.swift
//  XCTestEx
//
//  Created by Никита Гуляев on 14.08.2024.
//

import Foundation

class Calculator {
    func add(_ a: Double, _ b: Double) -> Double {
        return a + b
    }

    func subtract(_ a: Double, _ b: Double) -> Double {
        return a - b
    }

    func multiply(_ a: Double, _ b: Double) -> Double {
        return a * b
    }

    func divide(_ a: Double, _ b: Double) -> Double {
        guard b != 0 else {
            print("Division by zero is not allowed.")
            return 0
        }
        return a / b
    }
}
