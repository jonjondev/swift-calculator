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

// Catches possible errors
do {
    // Creates an ExpressionHelper object and tells it to use standard operators
    // and sets expression to values supplied as arguments
    var expressionHelper: ExpressionHelper = try ExpressionHelper(expression: args)
    
    // Converts the expression to postfix notation for evaluation
    try expressionHelper.convertToPostfix()

    // Evaluates and prints the result
    let result = try expressionHelper.solveExpression()
    print(result)
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
