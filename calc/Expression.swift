//
//  Expression.swift
//  calc
//
//  Created by Jonathan Moallem on 15/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

/*
 * A struct to represent a given Expression.
 */
struct Expression: CustomStringConvertible {
    
    // Struct fields
    var operators: [String: Operator]
    var expression: [Node] = [Node]()
    
    // Custom stringification definition
    var description: String {
        var outputString: String = String()
        for node in expression {
            outputString += node.getValue() + " "
        }
        return outputString
    }
    
    
    /*
     * A constructor that nodifies each value in a given expression and
     * provides the option to turn off standard operators.
     *
     * If an issue occurs while nodifying values, it will throw an error.
     */
    init(expression: [String], useStandardOperators: Bool = true) throws {
        operators = useStandardOperators ? Operator.standardOperators : [String: Operator]()
        try nodify(expression: expression)
    }
    
    
    /*
     * Adds a new operator definition to operator dictionary.
     */
    mutating func addOperator(symbol: String, precedence: Int, operation: @escaping (Int, Int) -> Int, checkRightOperandZero: Bool) {
        operators[symbol] = Operator(precedence: precedence, operation: operation, checkRightOperandZero: checkRightOperandZero)
    }
    
    
    /*
     * A public method used to convert an infix expression into a
     * postfix expression by applying a Shunting-yard algorithm.
     */
    mutating func convertToPostfix() throws {
        var outputQueue = [Node]()
        var operatorStack = [Node]()
        
        for node in expression {
            if try node.isOperandNode() {
                outputQueue.append(node)
            }
            else {
                
                if !operatorStack.isEmpty {
                    // Setup while conditions
                    var operatorStackPrecedence: Int = try getNodePrecedence(operatorNode: operatorStack.last!)
                    let currentNodePrecedence: Int = try getNodePrecedence(operatorNode: node)
                    
                    while !operatorStack.isEmpty && operatorStackPrecedence >= currentNodePrecedence && node.getValue() != "(" {
                        let poppedNode: Node? = operatorStack.popLast()
                        outputQueue.append(poppedNode!)
                        
                        // Update while conditions
                        if !operatorStack.isEmpty {
                            operatorStackPrecedence = try getNodePrecedence(operatorNode: operatorStack.last!)
                        }
                    }
                }
                operatorStack.append(node)
            }
            
            if node.getValue() == "(" {
                operatorStack.append(node)
            }
            else if node.getValue() == ")" {
                while operatorStack.last!.getValue() != "(" {
                    let poppedNode: Node? = operatorStack.popLast()
                    outputQueue.append(poppedNode!)
                }
            }
        }
        
        while operatorStack.count > 0 {
            let poppedNode: Node? = operatorStack.popLast()
            outputQueue.append(poppedNode!)
        }
        expression = outputQueue
    }
    
    
    /*
     * A method to solve a postfix notation expression,
     * returning it as an integer value.
     */
    func solveExpression() throws -> Int {
        var stack = [Node]()
        
        for node in expression {
            if try node.isOperandNode() {
                stack.append(node)
            }
            else {
                let valueOne: Int = stack.popLast()!.getIntValue()
                let valueTwo: Int = stack.popLast()!.getIntValue()
                let operatorType: Operator = try getOperator(operatorNode: node)
                let result: Int = try operatorType.performOperation(on: valueOne, and: valueTwo)
                let resultString: String = String(result)
                stack.append(Node(value: resultString))
            }
        }
        return stack.popLast()!.getIntValue()
    }
    
    
    /*
     * A helper function to turn all given values of a string array
     * into node values and store them in the expression array.
     *
     * Will throw errors if a given value is invalid.
     */
    mutating private func nodify(expression values: [String]) throws {
        for value in values {
            let node = Node(value: value)
            if try !node.isOperandNode() && node.getValue() != "(" && node.getValue() != ")" {
                try _ = getOperator(operatorNode: node)
            }
            expression.append(node)
        }
    }
    
    /*
     * A helper function to return a given operator node's precedence.
     */
    private func getNodePrecedence(operatorNode: Node) throws -> Int {
        return try getOperator(operatorNode: operatorNode).precedence
    }
    
    
    /*
     * A helper function to return the corresponding Operator object by
     * its symbol.
     *
     * It will throw an error if the operator cannot be found (undefined).
     */
    private func getOperator(operatorNode: Node) throws -> Operator {
        
        let operatorType = operators[operatorNode.getValue()]
        if operatorType != nil {
            return operatorType!
        }
        throw CalculationError.undefinedOperator(undefinedOperator: operatorNode.getValue())
    }
    
}
