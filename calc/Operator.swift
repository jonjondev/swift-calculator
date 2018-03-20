//
//  Operator.swift
//  calc
//
//  Created by Jonathan Moallem on 16/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

/*
 * A struct to represent a given Operator.
 */
struct Operator {
    
    // Struct fields
    let precedence: Int
    private let checkRightOperandZero: Bool
    private let operation: (Int, Int) -> Int
    
    // Provides a static set of standard operators for usage
    static let standardOperators: [String: Operator] = [
        "+": Operator(precedence: 2, operation: (+)),
        "-": Operator(precedence: 2, operation: (-)),
        "x": Operator(precedence: 3, operation: (*)),
        "/": Operator(precedence: 3, operation: (/), checkRightOperandZero: true),
        "%": Operator(precedence: 3, operation: (%), checkRightOperandZero: true)
    ]
    
    
    /*
     * A constructor that initialises the precendence of the
     * Operator, its operation function and takes an optional
     * parameter to check if the right operand is zero.
     */
    init(precedence: Int, operation: @escaping (Int, Int) -> Int, checkRightOperandZero: Bool = false) {
        self.precedence = precedence
        self.operation = operation // This is a function matching (Int, Int) -> Int
        self.checkRightOperandZero = checkRightOperandZero // Forces it into a Bool
    }
    
    
    /*
     * A public method that performs the Operator's operation on two
     * supplied Int values (the operands) and returns the result.
     *
     * If operator specifies that it should check the right operand
     * and the right operand is zero, it will throw an error for
     * attempting to deivide by zero.
     */
    func performOperation(on operandOne: Int, and operandTwo: Int) throws -> Int {
        if checkRightOperandZero && operandOne == 0 {
            throw CalculationError.dividedByZero
        }
        return operation(operandTwo, operandOne)
    }
}
