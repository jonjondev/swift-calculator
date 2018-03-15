//
//  Node.swift
//  calc
//
//  Created by Jonathan Moallem on 14/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

class Node {
    let value: String
    var parent: Node?
    var leftChild: Node?
    var rightChild: Node?
    
    init(value: String) {
        self.value = value
    }
    
    func getValue() -> String {
        return value
    }
    
    func isOperandNode() -> Bool  {
        return Int(value) != nil
    }
    
    func getPrecedence() -> Int {
        switch value {
        case "+", "-":
            return 2
        case "*", "/", "%":
            return 3
        default:
            return 0
        }
    }
}
