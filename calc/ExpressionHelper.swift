//
//  ExpressionHelper.swift
//  calc
//
//  Created by Jonathan Moallem on 15/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

class ExpressionHelper {
    
    static func createPostfix(values: [String]) -> [Node] {
        var outputQueue = [Node]()
        var operatorStack = [Node]()
        
        for value in values {
            let node = Node(value: value)
            
            if node.isOperandNode() {
                outputQueue.append(node)
            }
            else {
                while operatorStack.count > 0 && operatorStack.last!.getPrecedence() >= node.getPrecedence() && node.getValue() != "(" {
                    let poppedNode: Node? = operatorStack.popLast()
                    outputQueue.append(poppedNode!)
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
        return outputQueue
    }
    
    private static func performOperation(operandOne: Node, operandTwo: Node, operatorNode: Node) -> Node {
        var result: Int
        switch operatorNode.getValue() {
        case "+":
            result = operandTwo.getIntValue() + operandOne.getIntValue()
        case "-":
            result = operandTwo.getIntValue() - operandOne.getIntValue()
        case "x":
            result = operandTwo.getIntValue() * operandOne.getIntValue()
        case "/":
            result = operandTwo.getIntValue() / operandOne.getIntValue()
        case "%":
            result = operandTwo.getIntValue() % operandOne.getIntValue()
        default:
            return Node(value: "something went wrong")
        }
        return Node(value: String(result))
    }
    
    static func solveExpression(nodeArray: [Node]) -> Int {
        var stack = [Node]()
        
        for node in nodeArray {
            if node.isOperandNode() {
                stack.append(node)
            }
            else {
                let nodeOne: Node = stack.popLast()!
                let nodeTwo: Node = stack.popLast()!
                let result: Node = performOperation(operandOne: nodeOne, operandTwo: nodeTwo, operatorNode: node)
                
                stack.append(result)
            }
        }
        return stack.popLast()!.getIntValue()
    }
    
    static func printExpression(nodeArray: [Node]) {
        var outputString: String = ""
        for node in nodeArray {
            outputString += node.getValue() + " "
        }
        print(outputString)
    }
    
}
