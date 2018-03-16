//
//  Node.swift
//  calc
//
//  Created by Jonathan Moallem on 14/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

/*
 * A model class to represent a given Node.
 */
class Node {
    
    // Private class fields
    private let value: String
    
    
    /*
     * Node()
     *
     * A constructor that initialises the value of the Node.
     */
    init(value: String) {
        self.value = value
    }
    
    
    /*
     * getValue() -> String
     *
     * A getter method that returns the Node's value as a String.
     */
    func getValue() -> String {
        return value
    }
    
    
    /*
     * getIntValue() -> Int
     *
     * A getter method that returns the Node's value as an Int.
     */
    func getIntValue() -> Int {
        return Int(value)!
    }
    
    
    /*
     * isOperandNode() -> Bool
     *
     * A public method that returns whether the Node's value can
     * be converted to (and therefor must be) an operand as a Bool.
     */
    func isOperandNode() -> Bool  {
        return Int(value) != nil
    }
}
