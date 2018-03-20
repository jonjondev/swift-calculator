//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments // Gets the startup arguments
args.removeFirst() // Removes the name of the program

// Creates an ExpressionHelper object and tells it to use standard operators
let expressionHelper: ExpressionHelper = ExpressionHelper(useStandardOperators: true)

// Catches possible errors
do {
    // Sets the the ExpressionHelper with the values supplied as arguments
    try expressionHelper.setValues(values: args)
    
    // Converts the expression to postfix notation for evaluation
    try expressionHelper.convertToPostfix()

    // Evaluates and prints the result
    try expressionHelper.printSolvedExpression()
}
catch CalculationError.undefinedOperator(let undefinedOperator) {
    print("CalculationError.undefinedOperator: Found unspecified operator \(undefinedOperator), please check input and try again.")
    exit(1)
}
catch CalculationError.dividedByZero {
    print("CalculationError.dividedByZero: Cannot divide operand by zero.")
    exit(1)
}
catch CalculationError.operandOutOfBounds(let operand) {
    print("CalculationError.operandOutOfBounds: Operand [\(operand)] too small or large to handle.")
    exit(1)
}
