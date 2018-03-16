//
//  ExpressionHelper.swift
//  calc
//
//  Created by Jonathan Moallem on 15/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

/*
 * A helper class to assist in manipulating a given infix expression.
 */
class ExpressionHelper {
    
    // Private class fields
    private var operators: [Operator] = [Operator]()
    private var expression: [Node] = [Node]()
    
    
    /*
     * ExpressionHelper()
     *
     * A constructor that nodifies each value in a given expression and
     * initialises the operators that may be used to solve it.
     */
    init(values: [String], operators: [Operator]) {
        nodifyValues(values: values)
        self.operators = operators
    }
    
    
    /*
     * convertToPostfix()
     *
     * A public function used to convert an infix expression into a
     * postfix expression by applying a Shunting-yard algorithm.
     */
    func convertToPostfix() {
        var outputQueue = [Node]()
        var operatorStack = [Node]()
        
        for node in expression {
            if node.isOperandNode() {
                outputQueue.append(node)
            }
            else {
                if operatorStack.count > 0 {
                    while operatorStack.count > 0 && getOperator(operatorNode: operatorStack.last!)!.getPrecedence() >= getOperator(operatorNode: node)!.getPrecedence() && node.getValue() != "(" {
                        let poppedNode: Node? = operatorStack.popLast()
                        outputQueue.append(poppedNode!)
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
     * solveExpression() -> Int
     *
     * A helper method to solve a postfix notation expression,
     * returning it as an integer value.
     */
    private func solveExpression() -> Int {
        var stack = [Node]()
        
        for node in expression {
            if node.isOperandNode() {
                stack.append(node)
            }
            else {
                let valueOne: Int = stack.popLast()!.getIntValue()
                let valueTwo: Int = stack.popLast()!.getIntValue()
                let operatorType: Operator = getOperator(operatorNode: node)!
                let result: Int = operatorType.performOperation(operandOne: valueOne, operandTwo: valueTwo)
                let resultString: String = String(result)
                stack.append(Node(value: resultString))
            }
        }
        return stack.popLast()!.getIntValue()
    }
    
    
    /*
     * nodifyValues(values: [String])
     *
     * A helper function to turn all given values of a string array
     * into node values and store them in the expression array.
     */
    private func nodifyValues(values: [String]) {
        for value in values {
            let node = Node(value: value)
            expression.append(node)
        }
    }
    
    
    /*
     * getOperator(operatorNode: Node) -> Operator?
     *
     * A helper function to lookup and return the corresponding
     * Operator object by comparing it to a given node's String value.
     */
    private func getOperator(operatorNode: Node) -> Operator? {
        for operatorType in operators {
            if operatorType.getSymbol() == operatorNode.getValue() {
                return operatorType
            }
        }
        return nil
    }
    
    
    /*
     * printExpression()
     *
     * A public function that prints out an expression as it currently appears
     * in the expression array.
     */
    func printExpression() {
        var outputString: String = ""
        for node in expression {
            outputString += node.getValue() + " "
        }
        print(outputString)
    }
    
    
    /*
     * printSolvedExpression()
     *
     * A public function that prints out the result of an expression using the
     * solveExpression() helper function.
     */
    func printSolvedExpression() {
        print(solveExpression())
    }
    
}
