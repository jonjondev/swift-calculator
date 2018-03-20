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
// and sets expression to values supplied as arguments
var expression: Expression = Expression(expression: args)
let result: Int

// Catches possible errors
do {
    // Converts the expression to postfix notation for evaluation
    try expression.convertToPostfix()

    // Evaluates the expression
    result = try expression.solveExpression()
}
catch let error as CalculationError {
    print(error.localizedDescription)
    exit(1)
}

// Prints the result
print(result)
