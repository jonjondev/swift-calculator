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
    var expression: Expression = try Expression(expression: args)
    
    // Converts the expression to postfix notation for evaluation
    try expression.convertToPostfix()

    // Evaluates and prints the result
    let result = try expression.solveExpression()
    print(result)
}
catch let error as CalculationError {
    print(error.localizedDescription)
    exit(1)
}
