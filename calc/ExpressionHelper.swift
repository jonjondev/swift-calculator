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
                if operatorStack.count > 0 {
                    while operatorStack.last!.getPrecedence() >= node.getPrecedence() && node.getValue() != "(" {
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
        return outputQueue
    }
    
    static func printExpression(nodeArray: [Node]) {
        var outputString: String = ""
        for node in nodeArray {
            outputString += node.getValue() + " "
        }
        print(outputString)
    }
    
}
