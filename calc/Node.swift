//
//  Node.swift
//  calc
//
//  Created by Jonathan Moallem on 14/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

class Node {
    private let value: String
    
    init(value: String) {
        self.value = value
    }
    
    func getValue() -> String {
        return value
    }
    
    func getIntValue() -> Int {
        return Int(value)!
    }
    
    func isOperandNode() -> Bool  {
        return Int(value) != nil
    }
    
    func getPrecedence() -> Int {
        switch value {
        case "+", "-":
            return 2
        case "x", "/", "%":
            return 3
        default:
            return 0
        }
    }
}
