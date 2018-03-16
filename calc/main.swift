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

// Define all operators to be used here in a similar style
let definedOperators = [
    Operator(symbol: "+", precedence: 2, operation: (+)),
    Operator(symbol: "-", precedence: 2, operation: (-)),
    Operator(symbol: "x", precedence: 3, operation: (*)),
    Operator(symbol: "/", precedence: 3, operation: (/)),
    Operator(symbol: "%", precedence: 3, operation: (%))
]

// Creates an ExpressionHelper object with the arguments and defined operators
var expressionHelper: ExpressionHelper = ExpressionHelper(values: args, operators: definedOperators)

// Converts the expression to postfix notation for evaluation
expressionHelper.convertToPostfix()

// Evaluates and prints the result
expressionHelper.printSolvedExpression()
