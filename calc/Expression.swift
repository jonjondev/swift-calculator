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
            outputString += node.value + " "
        }
        return outputString
    }
    
    
    /*
     * A constructor that nodifies each value in a given expression and
     * provides the option to turn off standard operators.
     */
    init(expression: [String], useStandardOperators: Bool = true) {
        operators = useStandardOperators ? Operator.standardOperators : [String: Operator]()
        nodify(expression: expression)
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
                    var operatorStackPrecedence: Int = try getPrecedence(node: operatorStack.last!)
                    let currentNodePrecedence: Int = try getPrecedence(node: node)
                    
                    while !operatorStack.isEmpty && operatorStackPrecedence >= currentNodePrecedence && node.value != "(" {
                        guard let poppedNode: Node = operatorStack.popLast() else {
                            throw ExpressionError.missingNode
                        }
                        outputQueue.append(poppedNode)
                        
                        // Update while conditions
                        if !operatorStack.isEmpty {
                            operatorStackPrecedence = try getPrecedence(node: operatorStack.last!)
                        }
                    }
                }
                operatorStack.append(node)
            }
            
            if node.value == "(" {
                operatorStack.append(node)
            }
            else if node.value == ")" {
                while operatorStack.last!.value != "(" {
                    guard let poppedNode: Node = operatorStack.popLast() else {
                        throw ExpressionError.missingNode
                    }
                    outputQueue.append(poppedNode)
                }
            }
        }
        
        while operatorStack.count > 0 {
            guard let poppedNode: Node = operatorStack.popLast() else {
                throw ExpressionError.missingNode
            }
            outputQueue.append(poppedNode)
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
                guard let nodeOne: Node = stack.popLast(), let nodeTwo: Node = stack.popLast() else {
                        throw ExpressionError.incompleteExpression
                }
                
                let valueOne: Int = nodeOne.intValue()
                let valueTwo: Int = nodeTwo.intValue()
                
                let operatorType: Operator = try getOperator(node: node)
                let result: Int = try operatorType.performOperation(on: valueOne, and: valueTwo)
                let resultString: String = String(result)
                stack.append(Node(value: resultString))
            }
        }
        
        if let lastElement = stack.popLast() {
            return lastElement.intValue()
        }
        
        throw ExpressionError.emptyExpression
    }
    
    
    /*
     * A helper function to turn all given values of a string array
     * into node values and store them in the expression array.
     */
    mutating private func nodify(expression values: [String]) {
        for value in values {
            let node = Node(value: value)
            expression.append(node)
        }
    }
    
    
    /*
     * A helper function to return a given operator node's precedence.
     *
     * Will throw errors if the operator is undefined.
     */
    private func getPrecedence(node operatorNode: Node) throws -> Int {
        return try getOperator(node: operatorNode).precedence
    }
    
    
    /*
     * A helper function to return the corresponding Operator object by
     * its symbol.
     *
     * It will throw an error if the operator cannot be found (undefined).
     */
    private func getOperator(node operatorNode: Node) throws -> Operator {
        
        let operatorType = operators[operatorNode.value]
        if operatorType != nil {
            return operatorType!
        }
        throw CalculationError.undefinedOperator(undefinedOperator: operatorNode.value)
    }
    
}
